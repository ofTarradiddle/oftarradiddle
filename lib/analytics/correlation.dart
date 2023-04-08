import 'dart:math' as math;

List<List<double>> inputData = [
  [1.0, 2.0, 3.0],
  [4.0, 5.0, 6.0],
  [7.0, 8.0, 9.0]
];

double correlation(List<double> x, List<double> y) {
  double meanX = x.reduce((value, element) => value + element) / x.length;
  double meanY = y.reduce((value, element) => value + element) / y.length;
  double covXY = 0.0;
  double stdDevX = 0.0;
  double stdDevY = 0.0;
  for (int i = 0; i < x.length; i++) {
    covXY += (x[i] - meanX) * (y[i] - meanY);
    stdDevX += math.pow(x[i] - meanX, 2);
    stdDevY += math.pow(y[i] - meanY, 2);
  }
  covXY /= x.length;
  stdDevX = math.sqrt(stdDevX / x.length);
  stdDevY = math.sqrt(stdDevY / x.length);
  return covXY / (stdDevX * stdDevY);
}

List<List<double>> calculateCorrelations(List<List<double>> inputData) {
  List<List<double>> correlations = [];

  for (int i = 0; i < inputData.length; i++) {
    List<double> row = [];
    for (int j = 0; j < inputData.length; j++) {
      double corr = correlation(inputData[i], inputData[j]);
      row.add(corr);
    }
    correlations.add(row);
  }
  return correlations;
}
// List<List<double>> correlations = calculateCorrelations(inputData);

// import 'package:flutter_heatmap/flutter_heatmap.dart';
// Heatmap(
//   data: data,
//   colors: [Colors.red, Colors.yellow, Colors.green],
// ),


// for (int i = 0; i < inputData.length; i++) {
//   List<double> row = [];
//   for (int j = 0; j < inputData.length; j++) {
//     double x = inputData[i];
//     double y = inputData[j];
//     double xMean = x.reduce((a, b) => a + b) / x.length;
//     double yMean = y.reduce((a, b) => a + b) / y.length;
//     double numerator = 0;
//     double xStd = 0;
//     double yStd = 0;
//     for (int k = 0; k < x.length; k++) {
//       numerator += (x[k] - xMean) * (y[k] - yMean);
//       xStd += pow(x[k] - xMean, 2);
//       yStd += pow(y[k] - yMean, 2);
//     }
//     double denominator = sqrt(xStd) * sqrt(yStd);
//     double correlation = numerator / denominator;
//     row.add(correlation);
//   }
//   correlations.add(row);
// }