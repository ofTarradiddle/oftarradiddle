import 'dart:math';

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

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

class DropdownList extends ConsumerStatefulWidget {
  final String name;
  const DropdownList({super.key, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends ConsumerState<DropdownList> {
  bool isOpen = true;

  //todo this is not efficient, need to toggle without setstate so widget doesnt rebuild
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
                        onTap: () => {
                          //toggleDropdown()
                        },
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

class CorrelationTable extends ConsumerStatefulWidget {
  final String name;
  final String userId;

  // ignore: prefer_const_constructors_in_immutables
  CorrelationTable({super.key, required this.name, required this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _CorrelationTableState createState() => _CorrelationTableState();
}

class _CorrelationTableState extends ConsumerState<CorrelationTable> {
  Map<String, Map<String, double>> correlations = {};

  void computeCorrelations(List studyData) {
    // Clear existing correlations
    correlations.clear();

    // Compute correlations between all pairs of fields
    for (final entry
        in studyData.where((entry) => entry.userId == widget.userId)) {
      for (final fieldName1 in entry.data.keys) {
        final data1 = double.tryParse(entry.data[fieldName1] ?? '');
        if (data1 == null) continue;

        for (final fieldName2 in entry.data.keys) {
          final data2 = double.tryParse(entry.data[fieldName2] ?? '');
          if (data2 == null) continue;

          final corrKey = [fieldName1, fieldName2].join(' vs ');
          if (!correlations.containsKey(corrKey)) {
            correlations[corrKey] = {
              'correlation': 0.0,
              'count': 0.0,
              'sum1': 0.0,
              'sum2': 0.0,
              'sumSquares1': 0.0,
              'sumSquares2': 0.0
            };
          }

          final corrEntry = correlations[corrKey]!;
          corrEntry['count'] = corrEntry['count']! + 1;
          corrEntry['sum1'] = corrEntry['sum1']! + data1;
          corrEntry['sum2'] = corrEntry['sum2']! + data2;
          corrEntry['sumSquares1'] = corrEntry['sumSquares1']! + data1 * data1;
          corrEntry['sumSquares2'] = corrEntry['sumSquares2']! + data2 * data2;

          //

          final numerator =
              corrEntry['count']! * corrEntry['sum1']! * corrEntry['sum2']! -
                  corrEntry['sum1']! * corrEntry['sum2']!;

          final denominator = sqrt(
              (corrEntry['count']! * corrEntry['sumSquares1']! -
                      corrEntry['sum1']! * corrEntry['sum1']!) *
                  (corrEntry['count']! * corrEntry['sumSquares2']! -
                      corrEntry['sum2']! * corrEntry['sum2']!));

          corrEntry['correlation'] = numerator / denominator;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityDataProvider(widget.name)).when(
        data: (studyData) {
          computeCorrelations(studyData);

          final corrData = <List<dynamic>>[];
          for (final entry in correlations.entries) {
            corrData.add(
                [entry.key, entry.value['correlation']?.toStringAsFixed(2)]);
          }

          return Card(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Correlation')),
                  DataColumn(label: Text('Value')),
                ],
                rows: corrData.map((entry) {
                  return DataRow(cells: [
                    DataCell(Text(entry[0])),
                    DataCell(Text(entry[1])),
                  ]);
                }).toList(),
              ),
            ),
          );
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (Object error, StackTrace stackTrace) {
          return ErrorText(error: error.toString());
        });
  }
}

// decision tree

// class Node {
//   String label;
//   List<Node> children;

//   Node({required this.label, required this.children});
// }

// class DecisionTreeWidget extends StatelessWidget {
//   final String userId;

//   const DecisionTreeWidget({
//     Key? key,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Build the decision tree here
//     // ...

//     return Text('Decision Tree for User $userId');
//   }
// }

// class DecisionTreePainter extends CustomPainter {
//   final Node tree;
//   final double nodeRadius = 25.0;
//   final double nodePadding = 10.0;
//   final double levelPadding = 50.0;
//   final double lineWidth = 3.0;
//   final Color lineColor = Colors.black;

//   late Paint _nodePaint;
//   late Paint _linePaint;
//   late TextPainter _textPainter;

//   DecisionTreePainter(this.tree) {
//     _nodePaint = Paint()..color = Colors.green;
//     _linePaint = Paint()
//       ..color = lineColor
//       ..strokeWidth = lineWidth;
//     _textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.center,
//     );
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     _drawNode(canvas, tree, 0, size.width / 2, 0, size.height, 0);
//   }

//   void _drawNode(Canvas canvas, Node node, int level, double x, double y,
//       double maxX, double maxY) {
//     // Draw node
//     canvas.drawCircle(Offset(x, y), nodeRadius, _nodePaint);

//     // Draw label
//     _textPainter.text = TextSpan(
//       text: node.label,
//       style: const TextStyle(color: Colors.white, fontSize: 16),
//     );
//     _textPainter.layout();
//     _textPainter.paint(canvas,
//         Offset(x - _textPainter.width / 2, y - _textPainter.height / 2));

//     // Draw children
//     final childCount = node.children.length;
//     final childX = x - ((childCount - 1) * levelPadding) / 2;
//     final childY = y + nodeRadius + nodePadding;
//     for (int i = 0; i < childCount; i++) {
//       final child = node.children[i];
//       final childXPosition = childX + i * levelPadding;
//       canvas.drawLine(Offset(x, y + nodeRadius),
//           Offset(childXPosition, childY - nodeRadius), _linePaint);
//       _drawNode(canvas, child, level + 1, childXPosition, childY, maxX, maxY);
//     }
//   }

//   @override
//   bool shouldRepaint(DecisionTreePainter oldDelegate) {
//     return oldDelegate.tree != tree;
//   }
// }

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
