// import "dart:math" as math;

// class DecisionTree {
//   // The root node of the decision tree
//   Node root;

//   DecisionTree(List<List<double>> data, List<String> labels) {
//     root = _buildTree(data, labels);
//   }

//   Node _buildTree(List<List<double>> data, List<String> labels) {
//     // Base case: if all the samples belong to the same class, return a leaf node
//     if (isPure(data)) {
//       return Node(data: data, label: labels[0]);
//     }

//     // Select the best feature to split the data
//     int bestFeature = _getBestFeature(data, labels);

//     // Split the data on the best feature
//     List<List<List<double>>> splitData = _splitData(data, bestFeature);

//     // Create a new node with the best feature
//     Node node = Node(feature: bestFeature);

//     // Recursively build the left and right subtrees
//     node.left = _buildTree(splitData[0], labels);
//     node.right = _buildTree(splitData[1], labels);

//     return node;
//   }

//   int _getBestFeature(List<List<double>> data, List<String> labels) {
//     // Calculate the information gain for each feature
//     List<double> gains = List.filled(data[0].length, 0);
//     for (int i = 0; i < data[0].length; i++) {
//       gains[i] = _calculateInformationGain(data, labels, i);
//     }

//     // Return the feature with the highest information gain
//     return gains.indexOf(gains.reduce(math.max));
//   }

//   double _calculateInformationGain(
//       List<List<double>> data, List<String> labels, int feature) {
//     // Calculate the entropy of the data
//     double entropy = _calculateEntropy(labels);

//     // Split the data on the feature
//     List<List<List<double>>> splitData = _splitData(data, feature);

//     // Calculate the weighted average entropy of the split data
//     double weightedEntropy = 0;
//     for (List<List<double>> subData in splitData) {
//       weightedEntropy += (subData.length / data.length) *
//           _calculateEntropy(subData.map((d) => d[-1]).toList());
//     }

//     // Return the information gain
//     return entropy - weightedEntropy;
//   }

//   double _calculateEntropy(List<String> labels) {
//     // Calculate the probability of each class
//     Map<String, int> classCounts =
//         Map.fromIterable(labels, key: (l) => l, value: (l) => 0);
//     for (String label in labels) {
//       classCounts[label]++;
//     }
//     List<double> classProbabilities =
//         classCounts.values.map((c) => c / labels.length).toList();

//     // Calculate the entropy
//     double entropy = 0;
//     for (double p in classProbabilities) {
//       entropy -= p * math.log(p);
//     }
//     return entropy;
//   }

//   bool isPure(List<List<double>> data) {
//     String label = data[0][-1];
//     for (List<double> sample in data) {
//       if (sample[-1] != label) {
//         return false;
//       }
//     }
//     return true;
//   }

//   List<List<List<double>>> _splitData(List<List<double>> data, int feature) {
//     List<List<double>> leftData = [];
//     List<List<double>> rightData = [];
//     for (List<double> sample in data) {
//       if (sample[feature] == 0) {
//         leftData.add(sample);
//       } else {
//         rightData.add(sample);
//       }
//     }
//     return [leftData, rightData];
//   }
// }

// class Node {
//   List<double>? data;
//   int? feature;
//   String? label;
//   Node? left;
//   Node? right;

//   Node({this.feature, this.label, this.left, this.right});
// }

//  Node buildTree(List<List<double>> data) {
//     if (isPure(data)) {
//       return Node(label: data[0][-1]);
//     }

//     int feature = _chooseBestFeature(data);
//     List<List<List<double>>> splitData = _splitData(data, feature);
//     Node left = buildTree(splitData[0]);
//     Node right = buildTree(splitData[1]);

//     return Node(feature: feature, left: left, right: right);
//   }