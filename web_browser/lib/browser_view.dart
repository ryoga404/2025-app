import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'node/node.dart'; // Nodeクラスは編集せずインポート

main
class InAppWebviewSample extends StatefulWidget {
  const InAppWebviewSample({super.key});

  @override
  State<InAppWebviewSample> createState() => _InAppWebviewSampleState();
}

class _InAppWebviewSampleState extends State<InAppWebviewSample> {

  // WebViewのコントローラ
  late InAppWebViewController webViewController;

  // WebViewの設定
  final InAppWebViewSettings settings = InAppWebViewSettings(
    javaScriptEnabled: true, // JavaScriptを有効化
    useOnDownloadStart: true, // ダウンロード開始イベントを有効化
  );

  // 初期表示URL
  String url = 'https://google.com/';

  // 下部ボタンのリスト（ここに増やせばOK）
  final List<Map<String, dynamic>> bottomButtons = [
    {'label': 'Yahoo', 'color': Colors.orange, 'url': 'https://yahoo.co.jp'},
    {'label': 'Google', 'color': Colors.blue, 'url': 'https://google.com'},
    {'label': 'YouTube', 'color': Colors.red, 'url': 'https://youtube.com'},
    {'label': 'Bing', 'color': Colors.green, 'url': 'https://bing.com'},
    {'label': 'DuckDuckGo', 'color': Colors.purple, 'url': 'https://duckduckgo.com'},
    {'label': 'GitHub', 'color': Colors.black, 'url': 'https://github.com'},
  ];


  // ========= Node管理 =========
  Node? rootNode;
  Node? currentNode;

  void navigateTo(String newUrl) {
    webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(newUrl)));
  }

  // ========= 木構造表示用 =========
  List<Widget> _buildTree(Node node, {int depth = 0}) {
    List<Widget> widgets = [];
    widgets.add(Padding(
      padding: EdgeInsets.only(left: depth * 16.0),
      child: Text("• ${node.name}"),
    ));
    for (var child in node.children) {
      widgets.addAll(_buildTree(child, depth: depth + 1));
    }
    return widgets;
  }

  void _showTreePopup() {
    if (rootNode == null) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ツリー構造'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            children: _buildTree(rootNode!),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ブラウザ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_tree),
            onPressed: _showTreePopup,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 上部ボタン（Googleのみ残す）

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () => navigateTo('https://google.com/'),
                child: Container(
                  width: 120,
                  height: 40,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text(
                    'Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),


            // ================= WebView本体 =================
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(url)),
                initialSettings: settings,
                onWebViewCreated: (controller) => webViewController = controller,
                onLoadStart: (controller, url) {
                  log('Page started loading: $url');

                  if (url != null) {
                    if (rootNode == null) {
                      // 最初の検索ページ → ルートノード作成
                      rootNode = Node(url.toString());
                      currentNode = rootNode;
                    } else {
                      // それ以降の遷移 → 子ノードとして追加
                      Node child = Node(url.toString(), currentNode);
                      currentNode!.addChild(child);
                      currentNode = child;
                    }
                  }
                },

                onLoadStop: (controller, url) async =>
                    log('Page finished loading: $url'),
                onProgressChanged: (controller, progress) =>
                    log('Loading progress: $progress%'),
              ),
            ),
            // ================= 下部ボタン群（横スクロール可能） =================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 50, // ボタンエリアの高さ
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // 横スクロール
                  child: Row(
                    children: bottomButtons.map((btn) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: buildBottomButton(
                          btn['label'],
                          btn['color'],
                          btn['url'],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () async {
          if (await webViewController.canGoBack()) {
            await webViewController.goBack();
            // 木構造の現在ノードも親に戻す
            if (currentNode?.parent != null) {
              currentNode = currentNode!.parent;
            }
          }
        },
      ),
    );
  }

  // 下部ボタン作成
  Widget buildBottomButton(String label, Color color, String targetUrl) {
    return GestureDetector(
      onTap: () => navigateTo(targetUrl),
      child: Container(
        width: 100,
        height: 40,
        color: color,
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
