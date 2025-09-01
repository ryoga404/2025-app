import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_browser/node/mocked_node.dart';
import 'package:web_browser/tree_view/node_widget.dart';
import 'package:web_browser/node/node.dart'; // Nodeクラスのインポート
import 'dart:developer';

import 'package:web_browser/tree_view/tree_graph.dart';

class TreeView extends HookConsumerWidget {

  final Node rootNode;
  const TreeView({super.key,required this.rootNode});

  factory TreeView.mockingNode({Key? key}){
    return TreeView(key : key,rootNode:mockedNode(3,3));
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {; // 深さ2、子ノード数3のモックノードを生成
    log('Root node children count: ${rootNode.children.length}'); // ログを追加
    // ノードをNodeWidgetのリストに変換
    final List<Widget> nodeWidgets = rootNode.children
        .map((node) => NodeWidget(node: node))
        .toList();
    log('Node widgets count: ${nodeWidgets.length}'); // ログを追加

    return Scaffold(
      appBar: AppBar(title: const Text('Tree View')),
      body: InteractiveViewer(boundaryMargin: EdgeInsets.all(10),minScale: 0.1,child:  TreeGraph(rootNode: mockedNode(3, 3))),
    );
  }
}
