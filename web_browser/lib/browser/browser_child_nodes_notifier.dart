import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../node/node.dart';

///ノードの子ノードを管理するNotifier
///
///後にNode機能の方に統合予定。
final browserChildrenNodesNotifier =
    NotifierProvider.family<BrowserChildrenNodesNotifier, List<Node>, Node>(
      () => BrowserChildrenNodesNotifier(),
    );



class BrowserChildrenNodesNotifier extends FamilyNotifier<List<Node>, Node> {
  @override
  List<Node> build(Node node) {
    state = node.children;
    return state;
  }
  
  void addChild(Node node){
    state = [...state,node];
  }
}
