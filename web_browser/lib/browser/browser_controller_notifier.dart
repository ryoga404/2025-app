// BrowserControllerをRiverpodで管理するためのNotifier。
// 参照がなくなった場合は削除される。
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../node/node.dart';
import '../node/node_url.dart';    

import '../tree_view/treeview.dart';
import 'browser_current_node_notifier.dart';

/// ブラウザの状態を表すクラス
class BrowserState {
  final Node rootNode;
  final Node currentNode;
  final Map<String, String> urlTitles;
  final List<Node> bottomNodes;
  final String searchWord;
  final bool canAddChildNode;
  final InAppWebViewController? webViewController;

  const BrowserState({
    required this.rootNode,
    required this.currentNode,
    required this.urlTitles,
    required this.bottomNodes,
    required this.searchWord,
    required this.canAddChildNode,
    this.webViewController,
  });

  BrowserState copyWith({
    Node? rootNode,
    Node? currentNode,
    Map<String, String>? urlTitles,
    List<Node>? bottomNodes,
    String? searchWord,
    bool? canAddChildNode,
    InAppWebViewController? webViewController,
  }) {
    return BrowserState(
      rootNode: rootNode ?? this.rootNode,
      currentNode: currentNode ?? this.currentNode,
      urlTitles: urlTitles ?? this.urlTitles,
      bottomNodes: bottomNodes ?? this.bottomNodes,
      searchWord: searchWord ?? this.searchWord,
      canAddChildNode: canAddChildNode ?? this.canAddChildNode,
      webViewController: webViewController ?? this.webViewController,
    );
  }
}

/// BrowserControllerの状態管理を担当するNotifierクラス
class BrowserControllerNotifier extends AutoDisposeNotifier<BrowserState> {
  // WebViewの各種設定（JavaScript有効化、ダウンロードイベント有効化など）
  final InAppWebViewSettings settings = InAppWebViewSettings(
    javaScriptEnabled: true,
    useOnDownloadStart: true,
  );

  // アプリ起動時に最初に表示するURL
  final String initialUrl = 'https://www.google.com/';

  @override
  BrowserState build() {
    final rootNode = Node("      ");
    final urlTitles = <String, String>{initialUrl: "Google"};
    
    // currentNodeNotifierを監視して、現在ノードの変更に反応
    final currentNode = ref.watch(browserCurrentNodeNotifier);
    
    return BrowserState(
      rootNode: rootNode,
      currentNode: currentNode,
      urlTitles: urlTitles,
      bottomNodes: [],
      searchWord: "",
      canAddChildNode: true,
    );
  }

  /// ルートノードの初期化（検索ワードとURLで初期化）
  void setRootNode(String word, String url) {
    final newRootNode = NodeWithURL(word, url);
    final newUrlTitles = Map<String, String>.from(state.urlTitles);
    newUrlTitles[url] = word;
    
    state = state.copyWith(
      rootNode: newRootNode,
      currentNode: newRootNode,
      searchWord: word,
      urlTitles: newUrlTitles,
    );
    
    // currentNodeNotifierも更新
    ref.read(browserCurrentNodeNotifier.notifier).changeNode(newRootNode);
  }

  /// 履歴ツリー画面(TreeView)を表示。現在の履歴ツリーを渡す。
  void openTreeView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TreeView(rootNode: state.rootNode)),
    );
  }

  /// GoogleのURLかどうか判定。Google以外のページは履歴ボタンとして追加される。
  bool isGoogleUrl(String url) => url.startsWith(initialUrl);

  /// 下部ボタン用ノードリストにノードを追加（重複は追加しない）
  void addBottomNode(Node node) {
    if (!state.bottomNodes.any((n) => n.name == node.name)) {
      final newBottomNodes = List<Node>.from(state.bottomNodes)..add(node);
      state = state.copyWith(bottomNodes: newBottomNodes);
    }
  }

  /// WebView生成時に呼ばれるコールバック。WebViewコントローラーを保持する。
  void onWebViewCreated(InAppWebViewController controller) {
    state = state.copyWith(webViewController: controller);
  }

  /// ページ読み込み完了時に呼ばれるコールバック
  void onLoadStop(InAppWebViewController controller, WebUri? loadedUrl) async {
    if (loadedUrl == null) return;
    final urlStr = loadedUrl.toString();

    // ページタイトル取得（WebViewから）
    String? title = await controller.getTitle();
    final newUrlTitles = Map<String, String>.from(state.urlTitles);
    newUrlTitles[urlStr] = (title != null && title.isNotEmpty) ? title : urlStr;

    // 履歴ツリーに新ノード追加
    final newNode = Node(urlStr, state.currentNode);
    if (state.canAddChildNode) {
      state.currentNode.addChild(newNode);
      
      // 状態を更新
      state = state.copyWith(
        currentNode: newNode,
        urlTitles: newUrlTitles,
      );
      
      // currentNodeNotifierも更新
      ref.read(browserCurrentNodeNotifier.notifier).changeNode(newNode);
    } else {
      // canAddChildNodeがfalseの場合はurlTitlesのみ更新
      state = state.copyWith(urlTitles: newUrlTitles);
    }

    // Google以外のページなら下部ボタンリストに追加
    if (!isGoogleUrl(urlStr)) {
      addBottomNode(newNode);
    }
  }

  /// リンククリック時に呼ばれるコールバック（ルートノード用）
  Future<NavigationActionPolicy> shouldOverrideUrlLoadingRoot(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    final urlStr = navigationAction.request.url.toString();

    // タイトル取得
    String? title = await controller.getTitle();
    String nodeName = "";
    if (title != null && title.isNotEmpty) {
      nodeName = title.length > 10 ? "${title.substring(0, 10)}..." : title;
    } else {
      nodeName = urlStr;
    }

    // ルートノードの子ノードとして追加
    final childNode = NodeWithURL(nodeName, urlStr);
    state.rootNode.addChild(childNode);

    // 下部ボタンに追加
    addBottomNode(childNode);

    return NavigationActionPolicy.CANCEL;
  }

  /// リンククリック時に呼ばれるコールバック
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    final urlStr = navigationAction.request.url.toString();
    log('リンククリック: $urlStr');
    
    final newNode = Node(urlStr, state.currentNode);
    if (state.canAddChildNode) {
      state.currentNode.addChild(newNode);
      
      // 状態を更新
      state = state.copyWith(currentNode: newNode);
      
      // currentNodeNotifierも更新
      ref.read(browserCurrentNodeNotifier.notifier).changeNode(newNode);
    }
    
    if (!isGoogleUrl(urlStr)) {
      addBottomNode(newNode);
    }
    
    return NavigationActionPolicy.ALLOW;
  }

  /// 子ノード追加フラグの切り替え
  void canAddChildNodeSwitch() {
    state = state.copyWith(canAddChildNode: !state.canAddChildNode);
  }

  /// 現在ノードの変更
  void changeNode(Node node) {
    state = state.copyWith(currentNode: node);
    ref.read(browserCurrentNodeNotifier.notifier).changeNode(node);
  }

  /// 指定したURLにWebViewを遷移させる
  void navigateToParentNode(String url) {
    state.webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
  }
}

final browserControllerProvider =
    AutoDisposeNotifierProvider<BrowserControllerNotifier, BrowserState>(
      () => BrowserControllerNotifier(),
    );
