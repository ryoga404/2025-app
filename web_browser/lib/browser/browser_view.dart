import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'browser_controller.dart';
import 'browser_bottom_bar.dart';

// Webブラウザ画面のメインWidget
class InAppWebviewSample extends StatefulWidget {
  const InAppWebviewSample({super.key});

  @override
  State<InAppWebviewSample> createState() => _InAppWebviewSampleState();
}

// Webブラウザ画面の状態管理用Stateクラス
class _InAppWebviewSampleState extends State<InAppWebviewSample> {
  // ブラウザのロジック・状態管理用コントローラー
  late BrowserController controller;

  @override
  void initState() {
    super.initState();
    controller = BrowserController(); // コントローラー初期化
  }

  @override
  Widget build(BuildContext context) {
    // 画面構成（AppBar, WebView, 履歴ボタン, 操作ボタン）
    return Scaffold(
      appBar: AppBar(
        title: const Text('ブラウザ'), // 画面タイトル
        actions: [
          // 履歴ツリー画面への遷移ボタン
          IconButton(
            icon: const Icon(Icons.account_tree),
            onPressed: () => controller.openTreeView(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 親ノードへ戻るボタン表示条件をgetRootNodeで統一
            if (controller.parentNode != null && controller.currentNode != controller.getRootNode)
              controller.buildParentButton(context),
            // WebView本体（ページ表示）
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(controller.initialUrl)), // 初期URL
                initialSettings: controller.settings, // WebView設定
                onWebViewCreated: controller.onWebViewCreated, // WebView生成時コールバック
                onLoadStop: controller.onLoadStop, // ページ読み込み完了時コールバック
                shouldOverrideUrlLoading: controller.shouldOverrideUrlLoading, // リンククリック時コールバック
              ),
            ),
            // 下部履歴ボタンバー（履歴ノードが存在する場合のみ表示）
            if (controller.bottomNodes.isNotEmpty)
              BrowserBottomBar(controller: controller),
          ],
        ),
      ),
      // 画面右下の操作ボタン（戻る・履歴ノード追加切替）
      floatingActionButton: controller.buildFloatingButtons(context, setState),
    );
  }
}
