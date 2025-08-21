import 'dart:ui';

import 'package:web_browser/node.dart';

///ノードを描画のための情報を保持するクラス
class RenderNode {
  final Node node;
  final Offset position;
  final List<RenderNode> children;

  RenderNode({
    required this.node,
    required this.position,
  }): children = node.children
      .map((child) => RenderNode(node: child, position: position + Offset(0, 100)))
      .toList();

}
