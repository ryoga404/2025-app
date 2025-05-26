import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// アプリケーションのホーム画面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark And Check'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // マーク機能へのボタン
            _buildFeatureButton(
              context,
              'マーク',
              Icons.edit_document,
              () => context.push('/mark'),
            ),
            const SizedBox(height: 16),
            
            // 共有機能へのボタン
            _buildFeatureButton(
              context,
              '共有',
              Icons.share,
              () => context.push('/share'),
            ),
            const SizedBox(height: 16),
            
            // チェック機能へのボタン
            _buildFeatureButton(
              context,
              'チェック',
              Icons.check_circle,
              () => context.push('/check'),
            ),
          ],
        ),
      ),
    );
  }

  /// 機能ボタンを構築するウィジェット
  Widget _buildFeatureButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
} 