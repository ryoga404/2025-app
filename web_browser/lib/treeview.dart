import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TreeViewPage extends StatelessWidget {
  ///@brief ツリー構造を表示するページ
  TreeViewPage({super.key});

  final Node rootNode = mockedNode(100,2,);
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
              child: Column(
                children: [NodeTileWidget(node: node)]
              ),
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

class Node {
  ///ツリー構造のノードを表すクラス
  ///
  ///各ノードは名前[name]、子ノードのリスト[children]、親ノード[parent]を持つ。
  ///加えて、ノードの深さ[maxDepth]と幅[maxWidth]がそれぞれ初回参照時に計算される。

  final String _name;
  final List<Node> _children;
  final Node? _parent;
  late final int _maxDepth = _serchDepth();
  // late final List<int> _widthList = _listingWidth();

  /// コンストラクタ
  ///[name]ノードの名前
  ///[parent]親ノード.ルートノードの場合はnull
  Node(this._name, [this._parent]) : _children = [];

  void addChild(String childName) {
    _children.add(Node(childName, this));
  }

  int _serchDepth() {
    ///自分の深さを計算する。
    ///子ノード自身の深さを要求し、未計算であれば子ノードが更に下へ要求することで計算される。
    ///計算量増大の可能性あり。

    //0で初期化
    int depth = 0;
    for (Node child in _children) {
      // 子ノードの深さに1を加えた値（＝自分を0とした、そのノードに向かった深さ）と、
      // 現在のdepthを比較し、大きければdepthを更新する。
      if (depth < child.maxDepth + 1) depth = child.maxDepth + 1;
    }

    return depth;
  }

  // List<int> _listingWidth() {
  //   //0で初期化
  //   int width = 0;
  //   for (Node child in _children) {
  //     // 子ノードの幅と現在のwidthを比較し、大きければwidthを更新する。
  //     if (width < child.maxWidth) width = child.maxWidth;
  //   }

  //   return width + 1; // 自分自身の幅を加える

  // }

  String get name => _name;
  List<Node> get children => _children;
  Node get parent => _parent ?? (throw NoParentException());
  int get maxDepth => _maxDepth;
  // int get widthList => _widthList;
}

class NoParentException implements Exception {
  @override
  String toString() => 'No parent found for this node';
}

Node mockedNode(int depth, int childCount, [bool ramdomChildCount = false]) {
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
class _NodeDepth{
  ///mockedNodeを生成するためのクラス
}
