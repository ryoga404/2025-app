

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:web_browser/tree_view/search_tree.dart';

import '../node/node.dart';
import 'node_widget.dart';

class TreeGraph extends StatelessWidget with SearchTree {
  final Node rootNode;
  final Map<Node, Positioned> renderingNodes = {};
  final double verticalInterval = 20.0;
  final double horizonalInterval = 10.0;
  final double widgetSize = 100;
  TreeGraph({super.key, required this.rootNode});

  @override
  Widget build(BuildContext context) {
    log("tree graph rendering...");
    allRendering(rootNode, context); // contextを渡す
    final List<Positioned> rendering = [];
    renderingNodes.forEach((key, value) => rendering.add(value));
    log("rendering : ${rendering.map((node){
      final nodeWidget =node.child as NodeWidget;
      return nodeWidget.node.name;
    }).toList().toString()}");
    return Stack(children: rendering);
  }

  void allRendering(Node node, BuildContext context) { // BuildContextを追加
    renderingNodes.clear();
    Map<int, List<Node>> nodesByDepth = {};
    Map<Node, int> nodeHorizontalIndex = {}; // 各ノードの水平方向のインデックスを保持

    searchTree(
      startNode: node,
      getChildren: (node) => node.children,
      action: (currentNode) {
        final depth = findDepth(rootNode, currentNode);
        if (!nodesByDepth.containsKey(depth)) {
          nodesByDepth[depth] = [];
        }
        nodesByDepth[depth]!.add(currentNode);
        nodeHorizontalIndex[currentNode] = nodesByDepth[depth]!.length - 1;
      },
    );

    nodesByDepth.forEach((depth, nodesAtCurrentDepth) {
      for (var i = 0; i < nodesAtCurrentDepth.length; i++) {
        final currentNode = nodesAtCurrentDepth[i];
        final widgetNode = NodeWidget(node: currentNode);

        // leftとtopの計算ロジック
        // 各深さの中央に配置されるように調整
        final totalWidthOfDepth =
            (nodesAtCurrentDepth.length * widgetSize) +
                ((nodesAtCurrentDepth.length - 1) * horizonalInterval);
        final startLeft =
            (MediaQuery.of(context).size.width / 2) - // contextを使用
                (totalWidthOfDepth / 2);

        final left = startLeft + (i * (widgetSize + horizonalInterval));
        final top = (depth * (widgetSize + verticalInterval));

        renderingNodes[currentNode] = Positioned(
          left: left,
          top: top,
          child: widgetNode,
        );

        log("now depth:$depth . totalWidth:$totalWidthOfDepth. include ${nodesAtCurrentDepth.length} nodes => ${nodesAtCurrentDepth.map((e) => e.name).toString()}");
      }
    });
  }

  int findDepth(Node root, Node target, [int currentDepth = 0]) {
    if (root == target) {
      return currentDepth;
    }
    for (var child in root.children) {
      final depth = findDepth(child, target, currentDepth + 1);
      if (depth != -1) {
        return depth;
      }
    }
    return -1;
  }
}

class _LinePainter extends CustomPainter {
  final Offset startPos;
  final Offset endPos;

  _LinePainter(this.startPos, this.endPos);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5;

    canvas.drawLine(startPos, endPos, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
