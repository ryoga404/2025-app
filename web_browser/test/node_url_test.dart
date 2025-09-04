import 'package:test/test.dart';
import 'package:web_browser/node/node.dart';
import 'package:web_browser/node/node_url.dart';

void main() {
  group('NodeWithURL', () {
    test('NodeWithURLのコンストラクタはURL、名前、親を正しく設定する', () {
      final root = Node('root');
      final nodeWithUrl = NodeWithURL('https://example.com', 'example', root);

      expect(nodeWithUrl.url, 'https://example.com');
      expect(nodeWithUrl.name, 'example');
      expect(nodeWithUrl.parent, root);
    });

    test('NodeWithURLのコンストラクタは親がnullの場合も正しく設定する', () {
      final nodeWithUrl = NodeWithURL('https://example.com/no-parent', 'no-parent');

      expect(nodeWithUrl.url, 'https://example.com/no-parent');
      expect(nodeWithUrl.name, 'no-parent');
      expect(nodeWithUrl.parent, isNull);
    });

    test('NodeWithURLはNodeのプロパティを継承している', () {
      final root = Node('root');
      final nodeWithUrl = NodeWithURL('https://example.com', 'example', root);

      expect(nodeWithUrl.name, 'example');
      expect(nodeWithUrl.parent, root);
      expect(nodeWithUrl.children, isEmpty);

      final childNode = Node("node");
      nodeWithUrl.addChild(childNode);
      expect(nodeWithUrl.children,[childNode]);
    });
  });
}