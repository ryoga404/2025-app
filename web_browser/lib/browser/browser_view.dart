import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../node/node.dart';
import '../node/node_url.dart';
import 'browser_controller_notifier.dart';
import 'browser_bottom_bar.dart';

///Webブラウザ画面のメインWidget
///
///UIの描画を担当
class BrowserViewWidget extends HookConsumerWidget {
  const BrowserViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browserState = ref.watch(browserControllerProvider);
    final browserNotifier = ref.read(browserControllerProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('ブラウザ'), // 画面タイトル
        actions: [
          // 履歴ツリー画面への遷移ボタン
          IconButton(
            icon: const Icon(Icons.account_tree),
            onPressed: () => browserNotifier.openTreeView(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 親ノードへ戻るボタン表示条件をgetRootNodeで統一
            if (browserState.currentNode.parent != null &&
                browserState.currentNode != browserState.rootNode)
              ParentButton(parentNode: browserState.currentNode.parent),
            // WebView本体（ページ表示）
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(browserNotifier.initialUrl),
                ), // 初期URL
                initialSettings: browserNotifier.settings, // WebView設定
                onWebViewCreated:
                    browserNotifier.onWebViewCreated, // WebView生成時コールバック
                onLoadStop: browserNotifier.onLoadStop, // ページ読み込み完了時コールバック
                shouldOverrideUrlLoading:
                    browserNotifier.shouldOverrideUrlLoadingRoot, // リンククリック時コールバック
              ),
            ),
            // 下部履歴ボタンバー（履歴ノードが存在する場合のみ表示）
            if (browserState.bottomNodes.isNotEmpty)
              BrowserBottomBar(browserState: browserState),
          ],
        ),
      ),
      floatingActionButton: const FloatingButtons(),
    );
  }
}

/// 親ノードへ戻るボタンWidget
///
/// 親ノードが渡された場合にタップでき、遷移のプロバイダーを呼び出す
///
/// 親ノードが渡されなかった場合はバツ印と灰色になり、タップできない
class ParentButton extends ConsumerWidget {
  const ParentButton({super.key, this.parentNode});
  final Node? parentNode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          if (parentNode != null) {
            // parentNodeのURLを取得してナビゲート
            String url = '';
            if (parentNode is NodeWithURL) {
              url = (parentNode as NodeWithURL).url;
            } else {
              url = parentNode!.name; // Nodeの場合はnameをURLとして使用
            }
            ref.read(browserControllerProvider.notifier).navigateToParentNode(url);
          }
        },
        child: Container(
          width: 160,
          height: 40,
          color: Colors.blue,
          alignment: Alignment.center,
          child: parentNode != null
              ? Text(
                  //前段でnullチェックしてるのでnullにはならないが、念のため。
                  parentNode?.name ?? 'nullです',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              //親ノードがない場合はバツ印と灰色を表示
              : const Icon(Icons.cancel, color: Colors.grey),
        ),
      ),
    );
  }
}

class FloatingButtons extends ConsumerWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browserState = ref.watch(browserControllerProvider);
    final browserNotifier = ref.read(browserControllerProvider.notifier);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
                browserNotifier.canAddChildNodeSwitch();
              },
              child: Icon(
                browserState.canAddChildNode
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
            ),
            const SizedBox(width: 12),
            // ノード追加切替用のSwitch（ON/OFF状態を視覚的に表示・変更）
            Switch(
              value: browserState.canAddChildNode,
              onChanged: (value) {
                // スイッチ操作で履歴ノード追加のON/OFFを切り替える
                browserNotifier.canAddChildNodeSwitch();
              },
            ),
          ],
        ),
      ],
    );
  }
}
