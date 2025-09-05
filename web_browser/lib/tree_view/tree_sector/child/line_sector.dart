import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//線のウィジェット関連
/// ノード間の線を表すウィジェット
class LineSector extends StatelessWidget {
  final List<LineWidget> lines;

  const LineSector({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: lines,
    );
  }
}

class LineWidget extends ConsumerWidget {
  final Offset starPos;
  final Offset endPos;

  const LineWidget({super.key, required this.starPos, required this.endPos});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paint = ref.watch(toChildLinePaintNotifier);
    return CustomPaint(
      painter: LinePainter(linePaint: paint, startPos: starPos, endPos: endPos),
    );
  }
}

class LinePainter extends CustomPainter {
  final Paint linePaint;
  final Offset startPos;
  final Offset endPos;
  LinePainter({
    required this.linePaint,
    required this.startPos,
    required this.endPos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 線を描画するロジックをここに実装
    canvas.drawLine(startPos, endPos, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

//ノード間の

/// 子ノードへの線のPaintを管理するNotifier
class ToChildLinePainterNotifier extends Notifier<Paint> {
  @override
  Paint build() {
    return Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
  }
}

/// 子ノードへの線のPaintを提供するProvider
final toChildLinePaintNotifier =
    NotifierProvider<ToChildLinePainterNotifier, Paint>(
      ToChildLinePainterNotifier.new,
    );

//==============