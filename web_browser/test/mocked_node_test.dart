import 'package:flutter_test/flutter_test.dart';
import 'package:web_browser/node.dart';
import 'package:web_browser/mocked_node.dart';

void main() {
  group('mockedNode', () {
    test('depth 0, childCount 0 の場合、ルートノードのみが生成されること', () {
      final Node root = mockedNode(0, 0);
      expect(root.name, '1');
      expect(root.children.isEmpty, true);
    });

    test('depth 1, childCount 1 の場合、ルートノードと1つの子ノードが生成されること', () {
      final Node root = mockedNode(1, 1);
      expect(root.name, '1');
      expect(root.children.length, 1);
      expect(root.children[0].name, '1.1');
      expect(root.children[0].children.isEmpty, true);
    });

    test('depth 1, childCount 2 の場合、ルートノードと2つの子ノードが生成されること', () {
      final Node root = mockedNode(1, 2);
      expect(root.name, '1');
      expect(root.children.length, 2);
      expect(root.children[0].name, '1.1');
      expect(root.children[1].name, '1.2');
      expect(root.children[0].children.isEmpty, true);
      expect(root.children[1].children.isEmpty, true);
    });

    test('depth 2, childCount 1 の場合、深さ2までのノードが生成されること', () {
      final Node root = mockedNode(2, 1);
      expect(root.name, '1');
      expect(root.children.length, 1);
      expect(root.children[0].name, '1.1');
      expect(root.children[0].children.length, 1);
      expect(root.children[0].children[0].name, '1.1.1');
      expect(root.children[0].children[0].children.isEmpty, true);
    });

    test('randomChildCount が true の場合、子ノードの数がランダムになること', () {
      // 複数回実行してランダム性を確認
      bool variedChildCount = false;
      int firstChildCount = mockedNode(1, 5, true).children.length;
      for (int i = 0; i < 10; i++) {
        if (mockedNode(1, 5, true).children.length != firstChildCount) {
          variedChildCount = true;
          break;
        }
      }
      expect(variedChildCount, true);
    });

    test('生成されたノードの深さが指定されたdepthを超えないこと', () {
      final Node root = mockedNode(2, 2);
      // ルートノードの深さは0
      expect(root.maxDepth, lessThanOrEqualTo(2));
      for (Node child1 in root.children) {
        expect(child1.maxDepth, lessThanOrEqualTo(1));
        for (Node child2 in child1.children) {
          expect(child2.maxDepth, lessThanOrEqualTo(0));
          expect(child2.children.isEmpty, true);
        }
      }
    });
  });
}