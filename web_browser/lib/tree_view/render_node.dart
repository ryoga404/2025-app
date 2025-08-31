import '../node/node.dart';

///ノードを描画するための情報を保持するクラス
class RenderNode {
  final Node node;
  final double width;
  final double height;
  final double nodeRadius;
  final double fromLeft;
  final double fromTop;

  final List<RenderNode> children;
  RenderNode? parent;

  RenderNode(
    this.node,
    this.width,
    this.height,
    this.nodeRadius,
    this.fromLeft,
    this.fromTop, {
    this.parent,
  }) : children = [];

  void addChild(RenderNode child) {
    children.add(child);
  }
}
