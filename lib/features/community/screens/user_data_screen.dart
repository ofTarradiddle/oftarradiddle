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
import 'package:routemaster/routemaster.dart';

import '../../../models/community_model.dart';

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
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Stack(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: StudyDataChart(
                    name: name,
                    userId: user.name,
                    timeFilter: DateTime(2021, 1, 1),
                  ),
                ),
                Expanded(
                  child: DropdownList(name: name),
                ),
                CorrelationTable(
                  name: name,
                  userId: user.name,
                ),
                //DecisionTreeWidget(userId: name, studyData: const []),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
