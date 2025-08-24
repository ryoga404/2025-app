import 'dart:math';
import 'node.dart';

Node mockedNode(int depth, int childCount, [bool ramdomChildCount = false]) {
  // randomChildCountに応じて関数を設定
  Function() childFunction;
  if (ramdomChildCount) {
    Random random = Random();
    // 0~childCountランダムな数を返す関数
    childFunction = () => random.nextInt(childCount + 1);
  } else {
    // 常にchildCountを返す関数
    childFunction = () => childCount;
  }
  // 子ノードを生成
  Node rootNode = Node('1');
  List<_NodeDepth> waitList = [];
  waitList.add(_NodeDepth(rootNode, 0));
  // 待機列から要素を取り出し、子ノードを生成を繰り返す
  while (waitList.isNotEmpty) {
    _NodeDepth current = waitList.removeLast();
    Node node = current.node;
    //深さが指定の深さを超えたらスキップ
    if (current.depth >= depth) continue;

    // 子ノードを生成
    for (int i = 0; i < childFunction(); i++) {
      Node childNode = Node('${node.name}.${i + 1}', current.node);
      current.node.addChild(childNode);
      // 子ノードを待機列に追加
      waitList.add(_NodeDepth(childNode, current.depth + 1));
    }
  }
  return rootNode;
}

class _NodeDepth {
  ///mockedNodeを生成する際に、生成の待機列の要素となるクラス
  final Node node;
  final int depth;

  _NodeDepth(this.node, this.depth);
}
