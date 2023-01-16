import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/error_text.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';
import 'package:reddit_tutorial/models/study_data_model.dart';

import 'package:reddit_tutorial/features/auth/controlller/auth_controller.dart';

import '../../../models/user_model.dart';

/*
class AddDataScreen extends ConsumerWidget {
  final String name;
  AddDataScreen({super.key, required this.name});


  final List<TextEditingController> _controllers = [];
  final List<String> fieldNames = [];
  final String user = "";

  //alter to saveData
  void saveMods() {
    ref.read(communityControllerProvider.notifier).addMods(
          widget.name,
          uids.toList(),
          context,
        );
  }

  void saveData() {
    final entry = <String, dynamic>{};
    for (int i = 0; i < fieldNames.length; i++) {
      final fieldName = fieldNames[i];
      final controller = _controllers[i];
      entry[fieldName] = controller.text;
    }

    ref.read(communityControllerProvider.notifier).addData(
        widget.name,
        user,
        StudyData(
          userId: user,
          timestamp: DateTime.now().toIso8601String(),
          data: entry,
        ),
        context);
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: saveMods,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ref.watch(getCommunityByNameProvider(name)).when(
            data: (community) => ListView.builder(
              itemCount: community.fieldNames.length,
              itemBuilder: (BuildContext context, int index) {
                for (int i = 0; i < community.fieldNames.length; i++) {
                  fieldNames.add(community.fieldNames[i]);
                  //why is this continueing to print even when no updates?
                  _controllers.add(TextEditingController());
                  //print(studies2.fieldNames[i]);
                }
                final field = community.fieldNames[index];
                final controller = _controllers[index];

                return TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: field,
                  ),
                );
              },
            ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
 

  }
}
*/

//import study data model,
//use something like below to add study data
/*          final entry = <String, dynamic>{};
          for (int i = 0; i < widget.study.fieldNames.length; i++) {
            final fieldName = widget.study.fieldNames[i];
            final controller = _controllers[i];
            entry[fieldName] = controller.text;
          }
          setState(
            () {
              widget.study.data.add(
                StudyData(
                  userId: widget.userId,
                  timestamp: DateTime.now().toIso8601String(),
                  data: entry,
                ),
              );
            },
          );

          // Update studies in local JSON file
          final index = widget.studies.indexOf(widget.study);
          widget.studies[index] = widget.study;
          await _writeStudies(widget.studies);

          // Add the study to the set of studies that the user has entered data for
          widget.userStudies[widget.userId]!.add(widget.study.name);

          // Write the updated mapping of which studies each user has entered data for to the local JSON file
          await _writeUserStudies(widget.userStudies);
 */

//add study data entries to dcommunity model ...
//data should be set by study - user - data
//to be efficient in reading the data...

//check if data loads correctly, getting passed from router
//check if .addData functions in controller and repo work correctly.
class AddDataScreen extends ConsumerStatefulWidget {
  final String name;

  const AddDataScreen({
    super.key,
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends ConsumerState<AddDataScreen> {
  Set<String> uids = {};
  int ctr = 0;
  final List<TextEditingController> _controllers = [];
  final List<String> fieldNames = [];
  late TextEditingController nameController;
  late TextEditingController communityController;
  int loaded = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();

    for (int i = 0; i < fieldNames.length; i++) {
      _controllers[i].dispose();
    }
  }

  //alter to saveData
  void saveMods() {
    ref.read(communityControllerProvider.notifier).addMods(
          widget.name,
          uids.toList(),
          context,
        );
  }

  void saveData() {
    final entry = <String, dynamic>{};
    for (int i = 0; i < fieldNames.length; i++) {
      final fieldName = fieldNames[i];
      final controller = _controllers[i];
      entry[fieldName] = controller.text;
    }
    //this is the entry
    print(entry);

    ref.read(communityControllerProvider.notifier).addData(
        //widget.name,
        //nameController.text,
        StudyData(
          userId: nameController.text,
          name: widget.name,
          timestamp: DateTime.now().toIso8601String(),
          data: entry,
        ),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: saveData,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ref.watch(getCommunityByNameProvider(widget.name)).when(
            data: (community) => ListView.builder(
              itemCount: community.fieldNames.length,
              itemBuilder: (BuildContext context, int index) {
                if (loaded == 0) {
                  //communityController = TextEditingController(text: ref.read(communityProvider)!.name);
                  for (int i = 0; i < community.fieldNames.length; i++) {
                    fieldNames.add(community.fieldNames[i]);
                    //why is this continueing to print even when no updates?
                    _controllers.add(TextEditingController());
                    //print(studies2.fieldNames[i]);
                  }
                  loaded = 1;
                }

                final field = community.fieldNames[index];

                return TextField(
                  controller: _controllers[index],
                  decoration: InputDecoration(
                    labelText: field,
                  ),
                );
              },
            ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class AddDataScreen extends StatelessWidget {
  final String name;
  AddDataScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  void navigateToAddData(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  final fieldNames = ['one', 'two'];
  final List<TextEditingController> _controllers = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < fieldNames.length; i++) {
      //why is this continueing to print even when no updates?
      _controllers.add(TextEditingController());
      //print(studies2.fieldNames[i]);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Study Data!'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_moderator),
            title: const Text('Add Data'),
            onTap: () => navigateToAddData(context),
          
          ),

          // Data entry forms
          for (int i = 0; i < fieldNames.length; i++) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controllers[i],
                decoration: InputDecoration(
                  labelText: fieldNames[i],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}



*/
