import 'package:test/test.dart';

import '../lib/node/node.dart';

void main() {
  group('Node', () {
    test('Nodeのコンストラクタは名前と親を正しく設定する', () {
      final root = Node('root');
      expect(root.name, 'root');
      expect(() => root.parent, throwsA(isA<NoParentException>()));

      final child = Node('child', root);
      expect(child.name, 'child');
      expect(child.parent, root);
    });

    test('addChildは子ノードを正しく追加する', () {
      final parent = Node('parent');
      final child1 = Node('child1', parent);
      final child2 = Node('child2', parent);

      parent.addChild(child1);
      parent.addChild(child2);

      expect(parent.children, containsAll([child1, child2]));
      expect(parent.children.length, 2);
    });

    test('maxDepthは正しい最大深さを計算する', () {
      final root = Node('root');
      final child1 = Node('child1', root);
      final child2 = Node('child2', root);
      final grandChild1 = Node('grandChild1', child1);
      final grandChild2 = Node('grandChild2', child1);
      final greatGrandChild1 = Node('greatGrandChild1', grandChild2);

      root.addChild(child1);
      root.addChild(child2);
      child1.addChild(grandChild1);
      child1.addChild(grandChild2);
      grandChild2.addChild(greatGrandChild1);

      // ルートノードの深さは、その子孫の最大深さ
      expect(root.maxDepth, 3); // root -> child1 -> grandChild2 -> greatGrandChild1

      // 子ノードの深さ
      expect(child1.maxDepth, 2); // child1 -> grandChild2 -> greatGrandChild1
      expect(child2.maxDepth, 0); // child2 は子を持たない

      // 孫ノードの深さ
      expect(grandChild1.maxDepth, 0);
      expect(grandChild2.maxDepth, 1); // grandChild2 -> greatGrandChild1
      expect(greatGrandChild1.maxDepth, 0);

      // 空のノードの深さ
      final emptyNode = Node('empty');
      expect(emptyNode.maxDepth, 0);
    });

    test('NoParentExceptionは親がない場合にスローされる', () {
      final root = Node('root');
      expect(() => root.parent, throwsA(isA<NoParentException>()));
    });

    test('toStringはノード名を返す', () {
      final node = Node('testNode');
      expect(node.toString(), 'testNode');
    });
  });
}