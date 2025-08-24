import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_browser/node/mocked_node.dart';
import 'dart:developer'; // log関数を使用するためにインポート

import 'package:web_browser/node/node.dart';
import 'package:web_browser/tree_view/render_node.dart';

class TreeViewPage extends StatelessWidget {
  ///@brief ツリー構造を表示するページ
  TreeViewPage({super.key}) {
    log('TreeViewPageコンストラクタが呼び出されました。'); // コンストラクタの開始ログ
  }

  final Node rootNode = mockedNode(3, 2);
  final double nodeWidth = 100;
  final double nodeHeight = 100;

  @override
  Widget build(BuildContext context) {
    log('TreeViewPageのbuildメソッドが呼び出されました。'); // buildメソッドの開始ログ
    RenderNode node = RenderNode(node: rootNode, position: Offset(100, 100));
    if (kDebugMode) {
      print('Node max depth: ${node.node.maxDepth}'); // デバッグモードでノードの最大深度を表示
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
              width: nodeWidth * 3,
              height: 300,
              child: NodeWidget(node: node, width: 50, height: 50),
            ),
          ),
        ),
      ),
    );
  }
}

class NodeWidget extends StatelessWidget {
  final RenderNode node;
  final double width;
  final double height;
  final bool isExpanded = true;
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
    return CustomPaint(painter: NodePainter(node), child: Text(node.node.name));
  }
}

class NodePainter extends CustomPainter {
  final RenderNode node;
  final List<RenderNode> children;

  //painter
  NodePainter(this.node) : children = [] {
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
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, paint);
  }
  //子ノードまでの線を描画するメソッド
  void drawChildLines(Canvas canvas, RenderNode node, Paint paint) {
    log('NodePainterの子ノードまでの線を描画しています。'); // 子ノードまでの線の描画ログ
    for (final child in node.children) {
      canvas.drawLine(node.position, child.position, paint);
      drawChildLines(canvas, child, paint); // 再帰的に子ノードを描画
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
