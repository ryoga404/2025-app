import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../node/node.dart';
import '../tree_view/treeview.dart';

// ブラウザ画面の状態管理・ロジックを担当するコントローラークラス
class BrowserController {
  // WebViewの操作に使うコントローラー。Webページの遷移や履歴操作などを行う。
  late InAppWebViewController webViewController;

  // 子ノード（履歴ノード）を追加するかどうかのフラグ。trueなら履歴ツリーに追加する。
  bool canAddChildNode = true;

  // WebViewの各種設定（JavaScript有効化、ダウンロードイベント有効化など）
  final InAppWebViewSettings settings = InAppWebViewSettings(
    javaScriptEnabled: true,
    useOnDownloadStart: true,
  );

  // アプリ起動時に最初に表示するURL
  final String initialUrl = 'https://www.google.com/';

  // 履歴ツリーのルートノード（最初の親ノード）
  late Node rootNode;
  // 現在WebViewで表示しているノード（履歴ツリー上の現在位置）
  late Node _currentNode;

  // URLとページタイトルの対応表。WebViewで取得したタイトルを保存する。
  final Map<String, String> urlTitles = {};
  // 下部ボタンとして表示するノードのリスト（Google以外のページ履歴）
  final List<Node> bottomNodes = [];

  // コンストラクタ。履歴ツリーの初期化とGoogleタイトルの登録。
  BrowserController() {
    rootNode = Node("__ROOT__"); // ルートノード生成
    _currentNode = rootNode;     // 現在ノードをルートに設定
    urlTitles[initialUrl] = "Google"; // Googleのタイトルを登録
  }

  // 現在ノードの親ノードを取得（履歴ツリーで一つ前のページ）
  Node? get parentNode => _currentNode.parent;
  // 現在ノード（WebViewで表示中のページ）を取得
  Node get currentNode => _currentNode;
  // ルートノード（履歴ツリーの一番上）を取得
  Node get getRootNode => rootNode;

  // 履歴ツリー画面(TreeView)を表示。現在の履歴ツリーを渡す。
  void openTreeView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TreeView(rootNode: rootNode)),
    );
  }

  // 指定したURLにWebViewを遷移させる。履歴ツリーのノード名がURLになっている。
  void navigateTo(String url) {
    webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
  }

  // GoogleのURLかどうか判定。Google以外のページは履歴ボタンとして追加される。
  bool isGoogleUrl(String url) => url.startsWith(initialUrl);

  // 下部ボタン用ノードリストにノードを追加（重複は追加しない）
  void addBottomNode(Node node) {
    if (!bottomNodes.any((n) => n.name == node.name)) {
      bottomNodes.add(node);
    }
  }

  // WebView生成時に呼ばれるコールバック。WebViewコントローラーを保持する。
  void onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
  }

  // ページ読み込み完了時に呼ばれるコールバック
  // この関数はWebViewで新しいページの読み込みが完了したタイミングで実行される
  // 1. loadedUrlがnullの場合は何もしない（安全対策）
  // 2. 読み込んだURLの文字列を取得
  // 3. WebViewからページタイトルを取得し、urlTitlesマップに保存
  //    タイトルが取得できない場合はURL文字列をタイトルとして使う
  // 4. 履歴ツリーに新しいノード（ページ）を追加（canAddChildNodeがtrueの場合のみ）
  //    新ノードは現在ノードの子として追加し、現在ノードを新ノードに更新
  // 5. Google以外のURLの場合は下部ボタンリストにも追加（重複は追加しない）
  void onLoadStop(InAppWebViewController controller, WebUri? loadedUrl) async {
    if (loadedUrl == null) return; // 読み込みURLが無い場合は終了
    final urlStr = loadedUrl.toString(); // URL文字列取得

    // ページタイトル取得（WebViewから）
    String? title = await controller.getTitle();
    // タイトルが取得できない場合はURLをタイトルとして使う
    urlTitles[urlStr] = (title != null && title.isNotEmpty) ? title : urlStr;

    // 履歴ツリーに新ノード追加
    final newNode = Node(urlStr, _currentNode);
    if (canAddChildNode) {
      _currentNode.addChild(newNode); // 現在ノードの子として追加
      _currentNode = newNode;         // 現在ノードを新ノードに更新
    }

    // Google以外のページなら下部ボタンリストに追加
    if (!isGoogleUrl(urlStr)) {
      addBottomNode(newNode);
    }
  }

  // リンククリック時に呼ばれるコールバック
  // 1. 履歴ツリーにノード追加（canAddChildNodeがtrueの場合）
  // 2. Google以外なら下部ボタンリストに追加
  // 3. ページ遷移を許可
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      InAppWebViewController controller, NavigationAction navigationAction) async {
    final urlStr = navigationAction.request.url.toString();
    log('リンククリック: $urlStr'); // デバッグログ
    final newNode = Node(urlStr, currentNode);
    if (canAddChildNode) {
      currentNode.addChild(newNode); // 履歴ツリーに追加
      _currentNode = newNode;        // 現在ノード更新
    }
    if (!isGoogleUrl(urlStr)) {
      addBottomNode(newNode);        // 下部ボタンリストに追加
    }
    return NavigationActionPolicy.ALLOW; // ページ遷移を許可
  }

  // 親ノード（前のページ）へ戻るボタンのWidget生成
  // ボタン押下で親ノードのURLへ遷移
  Widget buildParentButton(BuildContext context) {
    final parentNode = _currentNode.parent;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () => navigateTo(parentNode!.name),
        child: Container(
          width: 160,
          height: 40,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            parentNode != null
                ? (urlTitles[parentNode.name] ?? parentNode.name)
                : '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // 画面右下の各種操作ボタン（戻る・ノード追加切替）のWidget生成
  // 戻るボタン：WebViewの履歴を戻る
  // ノード追加切替：履歴ツリーへの追加ON/OFF
  Widget buildFloatingButtons(BuildContext context, void Function(void Function()) setState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // --- WebViewの履歴を戻るボタン ---
        // FloatingActionButtonを押すとWebViewの「戻る」履歴があれば1つ戻る
        FloatingActionButton(
          heroTag: "backButton",
          child: const Icon(Icons.arrow_back),
          onPressed: () async {
            // WebViewに戻れる履歴がある場合のみ戻る
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            }
          },
        ),
        const SizedBox(height: 16),
        // --- ノード追加切替スイッチ ---
        // Rowで2つの操作（切替ボタンとスイッチ）を横並びに表示
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // ノード追加切替用のFloatingActionButton
            // アイコンはON/OFFでチェックボックス表示が変わる
            FloatingActionButton(
              heroTag: "addChildNodeSwitch",
              onPressed: () {
                // ボタン押下で履歴ノード追加のON/OFFを切り替える
                setState(() {
                  canAddChildNode = !canAddChildNode;
                });
              },
              child: Icon(
                canAddChildNode ? Icons.check_box : Icons.check_box_outline_blank,
              ),
            ),
            const SizedBox(width: 12),
            // ノード追加切替用のSwitch（ON/OFF状態を視覚的に表示・変更）
            Switch(
              value: canAddChildNode,
              onChanged: (value) {
                // スイッチ操作で履歴ノード追加のON/OFFを切り替える
                setState(() {
                  canAddChildNode = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
