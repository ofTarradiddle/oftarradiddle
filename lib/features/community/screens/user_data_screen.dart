import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/error_text.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/core/constants/firebase_constants.dart';
import 'package:reddit_tutorial/features/auth/controlller/auth_controller.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';
import 'package:reddit_tutorial/features/community/repository/communitory_repository.dart';
import 'package:reddit_tutorial/features/community/screens/dropdown_widget.dart';
import 'package:reddit_tutorial/models/study_data_model.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/*
class UserDataScreen extends ConsumerStatefulWidget {
  final String name;

  const UserDataScreen({
    super.key,
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends ConsumerState<UserDataScreen> {
  Set<String> uids = {};

  late TextEditingController nameController;
  late TextEditingController communityController;
  int loaded = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.name);
    final results = getCommunityDataProvider(widget.name);
    print(results);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (() {}),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ref.watch(getCommunityDataProvider(widget.name)).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final studydata = data[index];
                  print(studydata.name);
                  return ListTile(
                    leading: const Icon(Icons.input),
                    title: Text(studydata.name),
                    onTap: () => {print(studydata.name)},
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return ErrorText(error: error.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}

*/

class UserDataScreen extends ConsumerWidget {
  final String name;
  const UserDataScreen({super.key, required this.name});

  void makeDataset(List<StudyData> data) {
    //can pass this into the decision tree
    Map<String, List> fieldData = {};

    for (var item in data) {
      for (var field in item.data.keys) {
        if (!fieldData.containsKey(field)) {
          fieldData[field] = [];
        }
        fieldData[field]?.add(item.data[field]);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    print(name);
    final results = getCommunityDataProvider(name);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (() {}),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Stack(
        children: [
          //Time Series
          StudyDataChart(
            name: name,
            userId: user.name,
            timeFilter: DateTime(2021, 1, 1),
          ),

          //DataTable

          DropdownList(
            name: name,
          ),
        ],
      ),

      // ignore: todo
      //TODO
      //DROPDOWNS OF
      //DECISION TREE
      //CORRELATION MATRI

      /*
          ref.watch(getCommunityDataProvider(name)).when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final study = data[index];
                      final items = data[index].data;
                      print(study.name);
                      return ListTile(
                        leading: const Icon(Icons.input),
                        title: Text(
                            '${study.name}   ${items.values.map((e) => e.toString()).join(',')}'),
                        onTap: () => {},
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return ErrorText(error: error.toString());
                },
                loading: () => const Loader(),
              ),*/
    );
  }
}
