import 'package:flutter/material.dart';
import 'package:web_browser/node/mocked_node.dart';
import 'package:web_browser/router/router.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String title = "適材適書";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => BrowserViewRoute().go(context),
            child: Text("to browser!"),
          ),
          ElevatedButton(
            onPressed: () => TreeViewRoute($extra: mockedNode(3, 3)).go(context),
            child: Text("to treeview!")
          ),
        ],
      ),
    );
  }
}