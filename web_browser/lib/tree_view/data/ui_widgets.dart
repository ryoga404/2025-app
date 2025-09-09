

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final verticalIntervalNotifier =
    NotifierProvider<VerticalIntervalNotifier, double>(
      VerticalIntervalNotifier.new,
    );

class VerticalIntervalNotifier extends Notifier<double> {
  @override
  double build() {
    return 100.0; // 垂直間隔を20ピクセルに設定
  }
}

///ノードの高さ（画面全体の描画基準）を管理するNotifier
final nodeHeightNotifier = NotifierProvider<NodeHeightNotifier, double>(
  NodeHeightNotifier.new,
);

class NodeHeightNotifier extends Notifier<double> {
  @override
  double build() {
    return 100.0; // ノードの高さを1000ピクセルに設定
  }
}

///ノードの幅（同じく画面全体の描画基準）を管理するNotifier
final nodeWidthNotifier = NotifierProvider<NodeWidthNotifier, double>(
  NodeWidthNotifier.new,
);

class NodeWidthNotifier extends Notifier<double> {
  @override
  double build() {
    return 100.0; // ノードの幅を100ピクセルに設定
  }
}

/// ノードのPaintを管理するNotifier
final nodePaintNotifier = NotifierProvider<NodePaintNotifier, Paint>(
  NodePaintNotifier.new,
);

class NodePaintNotifier extends Notifier<Paint> {
  @override
  Paint build() {
    return Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..style = PaintingStyle.fill;
  }
}

//==============
