
mixin SearchTree {
  ///木構造を幅優先探索する関数
  ///
  /// - `startNode`探索を開始するルートノード。型は不問。
  /// - `getChildren`子要素のListを返す関数。
  /// - `action`子要素に対して行う関数。
  void searchTree<T>({
    required T startNode,
    required List<T> Function(T node) getChildren,
    required void Function(T node) action,
  }) {
    final List<T> queue = [];
    queue.add(startNode);

    while (queue.isNotEmpty) {
      final T currentNode = queue.removeAt(0);
      List<T> children = getChildren(currentNode);
      for (T child in children) {
        queue.add(child);
      }
      action(currentNode);
    }
  }
}
