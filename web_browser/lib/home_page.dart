import 'package:flutter/material.dart';
import 'package:web_browser/tree_view/treeview.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String title = "適材適書";

  @override
  Widget build(BuildContext context) {
    return TreeView.mockingNode();
  }
}