import 'package:flutter/material.dart';
import 'browser_controller.dart';

// 親ノード（前のページ）へ戻るボタンのWidget生成
// ボタン押下で親ノードのURLへ遷移
Widget buildParentButton(BuildContext context, BrowserController controller) {
  final parentNode = controller.currentNode.parent;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: GestureDetector(
      onTap: () => controller.navigateTo(parentNode!.name),
      child: Container(
        width: 160,
        height: 40,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          parentNode != null
              ? (controller.urlTitles[parentNode.name] ?? parentNode.name)
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
Widget buildFloatingButtons(BuildContext context, BrowserController controller, void Function(void Function()) setState) {
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
          if (await controller.webViewController.canGoBack()) {
            await controller.webViewController.goBack();
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
                controller.canAddChildNode = !controller.canAddChildNode;
              });
            },
            child: Icon(
              controller.canAddChildNode ? Icons.check_box : Icons.check_box_outline_blank,
            ),
          ),
          const SizedBox(width: 12),
          // ノード追加切替用のSwitch（ON/OFF状態を視覚的に表示・変更）
          Switch(
            value: controller.canAddChildNode,
            onChanged: (value) {
              // スイッチ操作で履歴ノード追加のON/OFFを切り替える
              setState(() {
                controller.canAddChildNode = value;
              });
            },
          ),
        ],
      ),
    ],
  );
}