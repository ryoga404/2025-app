import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'node/node.dart'; // Nodeクラスは編集せずインポート

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
  String initialUrl = 'https://google.com/';

  // カレントノード
  late Node rootNode;
  late Node currentNode;

  @override
  void initState() {
    super.initState();
    // 初期ルートノードは「Google検索」としておく
    rootNode = Node("Google");
    currentNode = rootNode;
  }

  void navigateTo(String newUrl) {
    webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(newUrl)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ブラウザ'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 上部ボタン（親ノードがあるときだけ表示）
            if (currentNode != rootNode)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    navigateTo(currentNode.parent.name);
                    setState(() {
                      currentNode = currentNode.parent;
                    });
                  },
                  child: Container(
                    width: 160,
                    height: 40,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(
                      currentNode.parent.name,
                      style: const TextStyle(
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
                initialUrlRequest: URLRequest(url: WebUri(initialUrl)),
                initialSettings: settings,
                onWebViewCreated: (controller) => webViewController = controller,
                onLoadStart: (controller, url) {
                  log('Page started loading: $url');
                },
                onLoadStop: (controller, loadedUrl) async {
                  if (loadedUrl == null) return;
                  log('Page finished loading: $loadedUrl');

                  final newUrl = loadedUrl.toString();

                  // 同じURLならスキップ
                  if (currentNode.name == newUrl) return;

                  // 子ノードを作って追加
                  final newNode = Node(newUrl, currentNode);
                  currentNode.addChild(newNode);

                  setState(() {
                    currentNode = newNode;
                  });
                },
                onProgressChanged: (controller, progress) =>
                    log('Loading progress: $progress%'),
              ),
            ),

            // ================= 下部ボタン群（現在の子ノードを表示） =================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: currentNode.children.map((childNode) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: buildBottomButton(childNode),
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
          }
        },
      ),
    );
  }

  // 下部ボタン作成（子ノード用）
  Widget buildBottomButton(Node node) {
    return GestureDetector(
      onTap: () {
        navigateTo(node.name);
        setState(() {
          currentNode = node;
        });
      },
      child: Container(
        width: 160,
        height: 40,
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          node.name,
          overflow: TextOverflow.ellipsis, // URLが長い場合は省略表示
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

//ボタンの表示をHTMLのタイトルタグを格納
