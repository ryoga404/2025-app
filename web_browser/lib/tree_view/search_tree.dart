
import 'dart:collection';

///木構造を幅優先探索する関数
///
/// - `startNode`探索を開始するルートノード。型は不問。
/// - `getChildren`子要素のListを返す関数。
/// - `action`子要素に対して行う関数。
void searchTree<T>({
  required T startNode,
  required List<T> Function(T node) getChildren,
  required void Function(T node) action
  }){
    final Queue<T> queue = Queue<T>();
    queue.add(startNode);

    while(queue.isNotEmpty){
      final T currentNode = queue.removeFirst();
      action(currentNode);
    }
}