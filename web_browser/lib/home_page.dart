import 'package:flutter/material.dart';
import 'package:web_browser/tree_view/treeview.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return TreeViewPage();
  }
}