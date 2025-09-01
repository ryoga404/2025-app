import 'package:flutter/material.dart';
import 'browser_controller.dart';
import '../node/node.dart';

// ブラウザ画面下部に表示する履歴ノードのボタンバーWidget
class BrowserBottomBar extends StatelessWidget {
  // コントローラー（履歴ノードやタイトル情報を参照するために使用）
  final BrowserController controller;
  const BrowserBottomBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // 横スクロール可能なRowで履歴ノードボタンを並べて表示
    return SizedBox(
      height: 50, // ボタンバーの高さ
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // 横方向スクロール
        child: Row(
          // 履歴ノードリスト（bottomNodes）をボタンとして並べる
          children: controller.bottomNodes.map((childNode) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5), // ボタン間の余白
              child: _buildBottomButton(childNode), // 個々の履歴ノードボタン生成
            );
          }).toList(),
        ),
      ),
    );
  }

  // 履歴ノード（Node）をボタンとして表示するWidget
  // ボタン押下で該当ノードのURLへWebViewを遷移
  Widget _buildBottomButton(Node node) {
    return GestureDetector(
      onTap: () => controller.navigateTo(node.name), // 画面遷移
      child: Container(
        width: 160, // ボタンの幅
        height: 40, // ボタンの高さ
        color: Colors.green, // ボタンの背景色
        alignment: Alignment.center, // テキスト中央寄せ
        child: Text(
          controller.urlTitles[node.name] ?? node.name, // タイトルがあれば表示、なければURL
          overflow: TextOverflow.ellipsis, // 長いタイトルは省略記号で切る
          style: const TextStyle(
            color: Colors.white, // 文字色
            fontWeight: FontWeight.bold, // 太字
            fontSize: 12, // フォントサイズ
          ),
        ),
      ),
    );
  }
}
