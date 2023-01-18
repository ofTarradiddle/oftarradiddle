import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/features/auth/controlller/auth_controller.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/study_data_model.dart';
import '../controller/community_controller.dart';

//barchart
//todo - 1 make a drop down
//add data table also as drop down,
//add other analytics drop downs (correlation, decision tree)
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class StudyDataChart extends ConsumerStatefulWidget {
  final String name;
  final String userId;
  final DateTime timeFilter;

  // ignore: prefer_const_constructors_in_immutables
  StudyDataChart(
      {super.key,
      required this.name,
      required this.userId,
      required this.timeFilter});

  @override
  // ignore: library_private_types_in_public_api
  _StudyDataChartState createState() => _StudyDataChartState();
}

class _StudyDataChartState extends ConsumerState<StudyDataChart> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityDataProvider(widget.name)).when(
        data: (studyData) {
          final dataSets = <Map<String, dynamic>>[];

          final userData =
              studyData.where((entry) => entry.userId == widget.userId);

          if (studyData.isNotEmpty) {
            for (final entry in userData) {
              for (final fieldName in entry.data.keys) {
                var data = entry.data[fieldName]
                    .toString()
                    .replaceAll(RegExp(r"\D"), "");
                var time = DateTime.parse(entry.timestamp);

                //filter time to show in chart
                if (time.compareTo(widget.timeFilter) > 0) {
                  var intData = [int.parse(data)];
                  print(intData);
                  // ignore: unnecessary_type_check
                  if (intData is List<dynamic>) {
                    var timeSeriesData = intData
                        .map((value) => TimeSeriesSales(time, value))
                        .toList();
                    var exists = false;

                    for (var set in dataSets) {
                      if (fieldName == set['id']) {
                        exists = true;
                      }
                    }

                    if (exists) {
                      // Check if the fieldName is already in the dataSets list
                      var existingDataSet = dataSets
                          .firstWhere((dataSet) => dataSet['id'] == fieldName);

                      // If the fieldName is already in the dataSets list, append the timeSeriesData to the existing time series
                      existingDataSet['data'].addAll(timeSeriesData);
                    } else {
                      // If the fieldName is not in the dataSets list, add a new entry to the dataSets list
                      dataSets.add(
                        {
                          'id': fieldName,
                          'data': timeSeriesData,
                        },
                      );
                    }
                  }
                }
              }
            }

            // Create the series object using a for loop
            var series = <charts.Series<dynamic, String>>[];
            for (var dataSet in dataSets) {
              series.add(
                charts.Series(
                  id: dataSet['id'] as String,
                  domainFn: (dynamic sales, _) => sales.time.toString(),
                  measureFn: (dynamic sales, _) => sales.sales,
                  data: dataSet['data'] as List<dynamic>,
                ),
              );
            }

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 300,
                  width: 900,
                  child: charts.BarChart(
                    series,
                    behaviors: [
                      charts.SlidingViewport(),
                      charts.PanAndZoomBehavior(),
                      charts.SeriesLegend(
                        position: charts.BehaviorPosition.bottom,
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                      ),
                    ],
                    animate: true,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("No data"),
            );
          }
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (Object error, StackTrace stackTrace) {
          return ErrorText(error: error.toString());
        });
  }
}

/*
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
*/

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
