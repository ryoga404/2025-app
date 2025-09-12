import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../node/node.dart';

///現在のノードの保持と変更を担当する。
final browserCurrentNodeNotifier = NotifierProvider<BrowserCurrentNodeNotifier,Node>(
  () => BrowserCurrentNodeNotifier(),
);

class BrowserCurrentNodeNotifier extends Notifier<Node> {
  @override
  Node build() {
    return Node("root");
  }
  void changeNode(Node node){
    state = node;
  }
}