import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_browser/tree_view/search_tree.dart';
import '../node/mocked_node.dart';
import 'dart:developer'; // log関数を使用するためにインポート

import '../tree_view/render_node.dart';
import 'mocked_render_node.dart';

///ツリー構造を表示するページ
class TreeViewPage extends StatelessWidget {
  TreeViewPage({super.key}) {
    log('TreeViewPageコンストラクタが呼び出されました。'); // コンストラクタの開始ログ
  }

  final RenderNode rootNode = RenderNode(
    node: mockedNode(3, 2),
    position: Offset(100, 100),
  );
  final double nodeWidth = 100;
  final double nodeHeight = 100;

  @override
  Widget build(BuildContext context) {
    log('TreeViewPageのbuildメソッドが呼び出されました。'); // buildメソッドの開始ログ
    mockedRenderNode(rootNode, 300, 300);
    if (kDebugMode) {
      print('Node max depth: ${rootNode.node.maxDepth}'); // デバッグモードでノードの最大深度を表示
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
              width: nodeWidth * 50,
              height: 3000,
              child: fullRendering(),
            ),
          ),
        ),
      ),
    );
  }

  //全てのnodeWidgetをStackで返す
  Stack fullRendering() {
    return Stack(children: getAllNodeWidgets());
  }

  List<NodeWidget> getAllNodeWidgets() {
    final List<RenderNode> nodes = [];
    searchTree(
      startNode: rootNode,
      getChildren: (RenderNode node) => node.children,
      action: (RenderNode node) => nodes.add(node),
    );
    for (var node in nodes) {
      log("${node.node.name}:(${node.position.dx},${node.position.dy})");
    }
    ;
    return nodes
        .map((node) => NodeWidget(node: node, width: 1, height: 1))
        .toList();
  }
}

///ツリーを構成する１つのノードのウィジェット
///ノードと、子ノードまでの線の描画を担当
class NodeWidget extends StatelessWidget {
  final RenderNode node;
  final double width;
  final double height;
  NodeWidget({
    super.key,
    required this.node,
    required this.width,
    required this.height,
  }) {
    log('NodeWidgetコンストラクタが呼び出されました。'); // NodeWidgetコンストラクタの開始ログ
  }

  @override
  Widget build(BuildContext context) {
    log('NodeWidgetのbuildメソッドが呼び出されました。'); // NodeWidget buildメソッドの開始ログ
    return CustomPaint(
      painter: _NodePainter(node),
      child: Text(node.node.name),
    );
  }
}

///ノードを実際に描画するだけのクラス
class _NodePainter extends CustomPainter {
  final RenderNode node;
  final List<RenderNode> children;
  final double nodeRadius = 100;
  //painter
  _NodePainter(this.node) : children = [] {
    log('NodePainterコンストラクタが呼び出されました。'); // NodePainterコンストラクタの開始ログ
  }

  @override
  void paint(Canvas canvas, Size size) {
    log('NodePainterのpaintメソッドが呼び出されました。'); // NodePainter paintメソッドの開始ログ
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;

    //自身を描画
    log("Nodeを描画(${node.position.dx},${node.position.dy})");
    canvas.drawCircle(node.position, nodeRadius, paint);

    //線の色を変更し、子ノードへの線を描画
    paint.color = Colors.black;
    drawChildLines(canvas, node, paint);
  }

  //子ノードまでの線を描画するメソッド
  void drawChildLines(Canvas canvas, RenderNode node, Paint paint) {
    log("子ノードまでの線を描画しています。");

    //線の始点をノードの下部に設定。
  
    final Offset position = node.position;
    final Offset lineStart = Offset(position.dx, position.dy + nodeRadius);
    for (final child in node.children) {

      //線の終点をノード上部に
      final Offset childPos = child.position;
      final Offset lineEnd = Offset(childPos.dx, childPos.dy - nodeRadius);

      //線を描画
      canvas.drawLine(lineStart, lineEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    log(
      'NodePainterのshouldRepaintメソッドが呼び出されました。',
    ); // NodePainter shouldRepaintメソッドの開始ログ
    return false;
  }
}
