import 'package:flutter/material.dart';
import 'dart:math';

class TreeViewPage extends StatelessWidget {
  const TreeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tree View')),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          constrained: false,
          minScale: 0.5,
          maxScale: 4.0,
          child: SizedBox(
            width: 1000,
            height: 1000,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: MyCustomPainter(),
                    
                    child: Text("data"),
                  ),
                ),
                // Expanded(child: NodeWidget(node: mockedNode(3, 5, true))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NodeWidget extends StatelessWidget {
  final Node node;

  const NodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(node.name),
      controlAffinity: ListTileControlAffinity.leading,
      childrenPadding: const EdgeInsets.all(10.0),
      trailing: CustomPaint(),
      children: node.children.map((child) => NodeWidget(node: child)).toList(),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Custom painting logic goes here
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, paint);
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Return true if the painting needs to be updated
  }
}

class Node {
  final String _name;
  final List<Node> _children;
  final Node? _parent;

  Node(this._name, [this._parent]) : _children = [];

  void addChild(String childName) {
    _children.add(Node(childName, this));
  }

  Node get parent => _parent ?? (throw NoParentException());

  String get name => _name;
  List<Node> get children => _children;
}

class NoParentException implements Exception {
  @override
  String toString() => 'No parent found for this node';
}

Node mockedNode(int depth, int childCount, [ramdomChildCount = false]) {
  ///@brief モックのツリー構造を生成する。
  ///@param depth ノードの深さ
  ///@param childCount 各ノードの子ノード数
  ///@param ramdomChildCount 各ノードの子ノード数をランダムにするかどうか。trueを渡した場合は、0~childCountの範囲でランダムに生成
  ///@return Node 生成されたノードのルート

  void childGenerator(Node parent, Function() childCount, int nowDepth) {
    /// 子ノードを生成するヘルパー関数
    if (nowDepth >= depth) return; // 深さが指定された深さに達したら終了

    // 再帰的に子ノードを生成
    for (int i = 0; i < childCount(); i++) {
      parent.addChild('${parent.name}-${i + 1}');
      childGenerator(parent.children.last, childCount, nowDepth + 1);
    }
  }

  //rootNodeのため、第２引数（parent）は指定せずnullとする。
  Node rootNode = Node(1.toString());
  Function() childFunction;

  // randomChildCountに応じて関数を設定
  if (ramdomChildCount) {
    Random random = Random();

    // 0~childCountランダムな数を返す関数
    childFunction = () => random.nextInt(childCount + 1);
  } else {
    // 常にchildCountを返す関数
    childFunction = () => childCount;
  }

  // 最初のノードから子ノードを再帰的に生成
  childGenerator(rootNode, childFunction, 0);

  return rootNode;
}
