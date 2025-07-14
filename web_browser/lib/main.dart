import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyBrowserApp());
}

class MyBrowserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '検索付きブラウザ',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SearchBrowser(),
    );
  }
}

class SearchBrowser extends StatefulWidget {
  @override
  _SearchBrowserState createState() => _SearchBrowserState();
}

class _SearchBrowserState extends State<SearchBrowser> {
  late final WebViewController _controller;
  final TextEditingController _searchController =
  TextEditingController(text: 'Flutter');

  @override
  void initState() {
    super.initState();
    // WebViewController の初期化
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.google.com'));
  }

  void _handleSearch() {
    String input = _searchController.text.trim();
    if (input.isEmpty) return;

    Uri uri;
    if (input.startsWith('http')) {
      uri = Uri.parse(input);
    } else if (input.contains('.') && !input.contains(' ')) {
      uri = Uri.parse('https://$input');
    } else {
      final query = Uri.encodeComponent(input);
      uri = Uri.parse('https://www.google.com/search?q=$query');
    }

    _controller.loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('検索付きブラウザ')),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'URLまたは検索ワードを入力',
                    ),
                    onSubmitted: (_) => _handleSearch(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _handleSearch,
              ),
            ],
          ),
          Expanded(child: WebViewWidget(controller: _controller)),
        ],
      ),
    );
  }
}
