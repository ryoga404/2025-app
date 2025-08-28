import 'dart:ui';

import '../node/node.dart';
import 'render_node.dart';

///Nodeの子要素を解析しRenderNodeをの子要素を連続で生成するメソッド
///offsetXは隣の子ノード,Yは親ノードからの相対位置
void mockedRenderNode(RenderNode node, int offsetX, int offsetY) {
  //RenderNodeと深さの組み合わせ格納するキューを作成し、自身を追加
  List<MapEntry<RenderNode, int>> queue = [MapEntry(node, 0)];

  //キューが空になるまで繰り返す
  while (queue.isNotEmpty) {
    //キューの先頭を取り出す
    final MapEntry<RenderNode, int> current = queue.removeAt(0);

    //currentのx座標から
    //OffsetXと子要素の数を掛けて子要素の全長を求め、半分に割り、引くことで初期地点を設定。
    double currentOffsetX =
        current.key.position.dx -
        (offsetX * current.key.children.length).toDouble() / 2;

    //深さを計算
    double currentOffsetY = (current.value * offsetY).toDouble();

    //currentのRenderNodeが保持するnodeのchildrenをループ
    for (Node child in current.key.node.children) {
      //子ノードの位置を計算
      final childPosition = Offset(currentOffsetX, currentOffsetY);

      //次のx座標を増やす
      currentOffsetX += offsetX;

      //RenderNodeを生成し、子ノードとして追加
      final childRenderNode = RenderNode(node: child, position: childPosition);
      current.key.addChild(childRenderNode);

      //作成した子ノードを、深さを+1してキューに追加
      queue.add(MapEntry(childRenderNode, current.value + 1));
    }
  }
}