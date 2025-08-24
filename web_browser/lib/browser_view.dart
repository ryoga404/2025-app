import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'node/node.dart';

class InAppWebviewSample extends StatefulWidget {
  const InAppWebviewSample({super.key});

  @override
  State<InAppWebviewSample> createState() => _InAppWebviewSampleState();
}

class _InAppWebviewSampleState extends State<InAppWebviewSample> {
  late InAppWebViewController webViewController;
  final InAppWebViewSettings settings = InAppWebViewSettings(
    javaScriptEnabled: true,
    useOnDownloadStart: true,
  );

  String initialUrl = 'https://google.com/';
  late Node rootNode;
  late Node currentNode;
  final Map<String, String> urlTitles = {};

  int navigationCount = 0; // 遷移回数をカウント

  @override
  void initState() {
    super.initState();
    rootNode = Node("__ROOT__");
    currentNode = rootNode;
    urlTitles[initialUrl] = "Google"; // 初期タイトル
  }

  void navigateTo(String url) {
    webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
  }

  Node? getParent(Node node) {
    try {
      return node.parent;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final parentNode = getParent(currentNode);

    return Scaffold(
      appBar: AppBar(title: const Text('ブラウザ')),
      body: SafeArea(
        child: Column(
          children: [
            // 上部ボタン（親ノード）
            if (parentNode != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () => navigateTo(parentNode.name),
                  child: Container(
                    width: 160,
                    height: 40,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(
                      urlTitles[parentNode.name] ?? parentNode.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

            // WebView
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(initialUrl)),
                initialSettings: settings,
                onWebViewCreated: (controller) =>
                webViewController = controller,
                onLoadStop: (controller, loadedUrl) async {
                  if (loadedUrl == null) return;
                  final urlStr = loadedUrl.toString();
                  String? title = await controller.getTitle();
                  urlTitles[urlStr] =
                  (title != null && title.isNotEmpty) ? title : urlStr;

                  // 1回目と2回目の遷移はWebViewで表示
                  if (navigationCount < 2) {
                    final newNode = Node(urlStr, currentNode);
                    currentNode.addChild(newNode);
                    currentNode = newNode;
                    navigationCount++;
                  }

                  setState(() {});
                },
                shouldOverrideUrlLoading:
                    (controller, navigationAction) async {
                  final urlStr = navigationAction.request.url.toString();
                  log('リンククリック: $urlStr');

                  // 遷移回数が2回を超えた場合はWebView遷移させず下部に追加
                  if (navigationCount >= 2) {
                    final newNode = Node(urlStr, currentNode);
                    currentNode.addChild(newNode);
                    urlTitles[urlStr] = urlStr;
                    setState(() {});
                    return NavigationActionPolicy.CANCEL;
                  }

                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ),

            // 下部ボタン（子ノードを横スクロールで表示）
            SizedBox(
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

  Widget buildBottomButton(Node node) {
    return GestureDetector(
      onTap: () => navigateTo(node.name),
      child: Container(
        width: 160,
        height: 40,
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          urlTitles[node.name] ?? node.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }
}

//若干タイミングがバグっている点を修正
//下部ボタン一部タイトルタグがとれていない。（BODYの一部で代用？？）