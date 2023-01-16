import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/features/auth/controlller/auth_controller.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/study_data_model.dart';
import '../controller/community_controller.dart';

class DropdownList extends ConsumerStatefulWidget {
  final String name;
  const DropdownList({super.key, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends ConsumerState<DropdownList> {
  bool isOpen = false;

  void toggleDropdown() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toggleDropdown();
      },
      child: isOpen
          ? ref.watch(getCommunityDataProvider(widget.name)).when(
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
                        onTap: () => {toggleDropdown()},
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return ErrorText(error: error.toString());
                },
                loading: () => const Loader(),
              )
          : const ListTile(
              leading: Icon(Icons.input),
              title: Text('Data Items'),
            ),
    );
  }
}

/*
class DDScreen extends ConsumerStatefulWidget {
  final String name;
  const DDScreen({
    super.key,
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DDScreenState();
}

class _DDScreenState extends ConsumerState<DDScreen> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toggleDropdown(isOpen);
      },
      child: isOpen
          ? ref.watch(getCommunityDataProvider(widget.name)).when(
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
              )
          : const ListTile(
              leading: Icon(Icons.input),
              title: Text('Data Items'),
            ),
    );
  }
}

void toggleDropdown(isOpen) {
  isOpen = !isOpen;
}
*/