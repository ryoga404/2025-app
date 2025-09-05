
// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_browser/tree_view/tree_sector/tree_sector.dart';

import '../node/mocked_node.dart';
import '../node/node.dart';
import 'tree_sector/node_widget.dart';

class TreeView extends HookConsumerWidget {

  final Node rootNode;
  const TreeView({super.key,required this.rootNode});

  factory TreeView.mockingNode({Key? key}){
    return TreeView(key : key,rootNode:mockedNode(3,3));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    log('Root node children count: ${rootNode.children.length}'); // ログを追加

    return Scaffold(
      appBar: AppBar(title: const Text('Tree View')),
      body: InteractiveViewer(boundaryMargin: EdgeInsets.all(10),minScale: 0.1,child:  TreeSector(key:UniqueKey(),node: mockedNode(3, 3))),
    );
  }
}
