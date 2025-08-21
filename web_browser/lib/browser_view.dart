import 'dart:developer'; // ログ出力用（log関数を使う）
import 'package:flutter/material.dart'; // FlutterのUIライブラリ
import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // WebViewライブラリ



// StatefulWidget（状態を持つWidget）
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

  // ページ遷移用関数
  void navigateTo(String newUrl) {
    // WebViewに新しいURLを読み込ませる
    webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(newUrl)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // ノッチ部分を避ける
        child: Column(
          children: [
            // ================= 上部ボタン =================
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
                onWebViewCreated: (controller) =>
                webViewController = controller,
                onLoadStart: (controller, url) =>
                    log('Page started loading: $url'),
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
    );
  }

  // ================= 下部ボタン作成関数 =================
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
