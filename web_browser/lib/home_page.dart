import 'package:flutter/material.dart';
import 'package:web_browser/router/router.dart';
import 'package:web_browser/tree_view/treeview.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String title = "適材適書";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()=>BrowserViewRoute().go(context), child: Text("to browser!")),
          ElevatedButton(onPressed: ()=>TreeView.mockingNode(), child: Text("to treeview!"))
        ],
      ),
    );
  }
}