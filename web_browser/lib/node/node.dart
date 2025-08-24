

///ツリー構造のノードを表す
///
///
///
///* `name`　名前
///* `children`　子ノードのリスト
///* `parent`　親ノード。
///
///初回参照時に計算
///* `maxDepth`　ノードの最大深さ。
///* `maxWidth`　ノードの最大幅。
class Node {
  final String _name;
  final List<Node> _children;
  final Node? _parent;
  late final int _maxDepth = _serchDepth();
  // late final List<int> _widthList = _listingWidth();

  ///* `name`ノードの名前
  ///* `parent`親ノード（ルートノードの場合はnull）
  Node(this._name, [this._parent]) : _children = [];

  void addChild(Node childNode) {
    _children.add(childNode);
  }

  int _serchDepth() {
    ///自分の深さを計算する。
    ///子ノード自身の深さを要求し、未計算であれば子ノードが更に下へ要求することで計算される。
    ///計算量増大の可能性あり。

    if (_children.isEmpty) {
      return 0; // 子ノードがなければ深さは0
    }

    int maxDepthFound = 0;
    // スタックには、(ノード, そのノードの現在の深さ) のペアを格納
    // ここでの深さは、現在のノードを0とした場合の深さ
    List<MapEntry<Node, int>> stack = [];

    // 初期ノードの子ノードをスタックにプッシュ
    for (Node child in _children) {
      stack.add(MapEntry(child, 1)); // 子ノードは深さ1
    }

    while (stack.isNotEmpty) {
      MapEntry<Node, int> currentEntry = stack.removeLast();
      Node currentNode = currentEntry.key;
      int currentDepth = currentEntry.value;

      if (currentDepth > maxDepthFound) {
        maxDepthFound = currentDepth;
      }

      // 現在のノードの子ノードをスタックにプッシュ
      for (Node child in currentNode._children) {
        stack.add(MapEntry(child, currentDepth + 1));
      }
    }
    return maxDepthFound;
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
  @override
  String toString() => _name;
}

class NoParentException implements Exception {
  @override
  String toString() => 'No parent found for this node';
}
