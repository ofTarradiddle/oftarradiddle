// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/cupertino.dart';

// class TreeView extends StatelessWidget {
//   final Node tree;

//   const TreeView({Key? key, required this.tree}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: TreePainter(tree, context),
//     );
//   }
// }

// class TreePainter extends CustomPainter {
//   final Node tree;
//   final BuildContext context;

//   TreePainter(this.tree, this.context);

//   @override
//   void paint(Canvas canvas, Size size) {
//     _drawTree(canvas, size, tree);
//   }

//   void _drawTree(Canvas canvas, Node node, Offset offset) {
//     if (node == null) return;

//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = Colors.black;

//     canvas.drawCircle(offset, nodeSize / 2, paint);

//     final textPainter = TextPainter(
//         text: TextSpan(
//             text: node.splitValue != null
//                 ? node.splitValue.toStringAsFixed(3)
//                 : "",
//             style: TextStyle(color: Colors.white, fontSize: 12)),
//         textDirection: TextDirection.ltr)
//       ..layout();

//     textPainter.paint(
//         canvas, offset - Offset(textPainter.width / 2, textPainter.height / 2));

//     if (!node.isLeaf) {
//       _drawTree(canvas, node.left, offset + Offset(-nodeSize, nodeSize));
//       _drawTree(canvas, node.right, offset + Offset(nodeSize, nodeSize));
//     }
//   }

//   void _drawLeafNode(Canvas canvas, Size size, Node node) {
//     final label = node.output.toString();
//     final textSpan =
//         TextSpan(style: DefaultTextStyle.of(context).style, text: label);
//     final textPainter =
//         TextPainter(text: textSpan, textDirection: TextDirection.ltr);
//     textPainter.layout();
//     final textWidth = textPainter.width;
//     final textHeight = textPainter.height;
//     final x = (size.width - textWidth) / 2;
//     final y = (size.height - textHeight) / 2;
//     textPainter.paint(canvas, Offset(x, y));
//   }

//   void drawSplitNode(
//       Canvas canvas, Node? node, Offset offset, double nodeSize) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2;

//     final centerX = offset.dx + nodeSize / 2;
//     final centerY = offset.dy + nodeSize / 2;
//     final featureText = TextSpan(
//       text: node?.feature,
//       style: const TextStyle(color: Colors.black, fontSize: 12),
//     );
//     final featureTextPainter = TextPainter(
//       text: featureText,
//       textDirection: TextDirection.ltr,
//     );
//     featureTextPainter.layout();
//     featureTextPainter.paint(
//       canvas,
//       Offset(centerX - featureTextPainter.width / 2, centerY - nodeSize / 2),
//     );

//     final valueText = TextSpan(
//       text: node?.value?.toStringAsFixed(2),
//       style: const TextStyle(color: Colors.black, fontSize: 12),
//     );
//     final valueTextPainter = TextPainter(
//       text: valueText,
//       textDirection: TextDirection.ltr,
//     );
//     valueTextPainter.layout();
//     valueTextPainter.paint(
//       canvas,
//       Offset(centerX - valueTextPainter.width / 2, centerY + nodeSize / 4),
//     );

//     canvas.drawCircle(Offset(centerX, centerY), nodeSize / 2, paint);

//     // draw the lines to the left and right child
//     if (node?.left != null) {
//       canvas.drawLine(
//           Offset(centerX, centerY), offset + Offset(0, nodeSize), paint);
//       drawSplitNode(canvas, node?.left, offset + Offset(0, nodeSize), nodeSize);
//     }
//     if (node?.right != null) {
//       canvas.drawLine(
//           Offset(centerX, centerY), offset + Offset(nodeSize, nodeSize), paint);
//       drawSplitNode(
//           canvas, node?.right, offset + Offset(nodeSize, nodeSize), nodeSize);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// class Node {
//   final String? feature;
//   final double? value;
//   final int? output;
//   bool? isLeaf;
//   Node? left;
//   Node? right;

//   Node(
//       {this.feature,
//       this.value,
//       this.output,
//       this.isLeaf,
//       this.left,
//       this.right});
// }
