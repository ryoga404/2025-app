import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_browser/mocked_node.dart';

import 'package:web_browser/node.dart';

class TreeViewPage extends StatelessWidget {
  ///@brief ツリー構造を表示するページ
  TreeViewPage({super.key});

  final Node rootNode = mockedNode(100, 2);
  final double nodeWidth = 100;
  final double nodeHeight = 100;

  @override
  Widget build(BuildContext context) {
    Node node = rootNode;
    if (kDebugMode) {
      print('Node max depth: ${node.maxDepth}');
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Tree View')),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          constrained: false,
          minScale: 0.5,
          maxScale: 4.0,
          child: SizedBox(
            child: SizedBox(
              width: nodeWidth * 10,
              height: 3000,
              child: Column(children: [NodeTileWidget(node: node)]),
            ),
          ),
        ),
      ),
    );
  }
}

class NodeTileWidget extends StatelessWidget {
  const NodeTileWidget({super.key, required this.node});
  final Node node;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(node.name),
      children: node.children.map((child) {
        return NodeTileWidget(node: child);
      }).toList(),
    );
  }
}

class NodeWidget extends StatelessWidget {
  final Node node;
  final double width;
  final double height;
  const NodeWidget({
    super.key,
    required this.node,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(painter: NodePainter(), child: Text(node.name)),
    );
  }
}

class NodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Custom painting logic goes here
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true if the painting needs to be updated
  }
}

