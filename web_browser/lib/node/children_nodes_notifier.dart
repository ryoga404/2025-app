import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'node.dart';

///ノードの子ノードを管理するNotifier
final childrenNodesNotifier =
    NotifierProvider.family<ChildrenNodesNotifier, List<Node>, Node>(
      () => ChildrenNodesNotifier(),
    );

class ChildrenNodesNotifier extends FamilyNotifier<List<Node>, Node> {
  @override
  List<Node> build(Node node) {
    state = node.children;
    return state;
  }
}
