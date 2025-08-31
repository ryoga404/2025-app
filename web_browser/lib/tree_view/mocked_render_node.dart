import 'dart:ui';

import 'render_node.dart';
import 'search_tree.dart';

///Nodeの子要素を解析しRenderNodeの子要素を連続で生成するメソッド
///offsetXは隣の子ノード,Yは親ノードからの相対位置
class MockedRenderNode extends RenderNode with SearchTree {
  //ノードと設定。

  MockedRenderNode(
    super.node,
    super.width,
    super.height,
    super.nodeRadius,
    super.fromLeft,
    super.fromTop,){

    }
}
