import 'dart:ui';

import '../node/node.dart';

///ノードを描画するための情報を保持するクラス
class RenderNode {
  final Node node;
  final Offset position;
  final List<RenderNode> children;
  RenderNode? parent;
  RenderNode({required this.node, required this.position,RenderNode? parent}) : children = [];

  void addChild(RenderNode child) {
    children.add(child);
  }
}


