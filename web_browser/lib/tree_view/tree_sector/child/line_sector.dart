import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_browser/tree_view/data/tree_sector_with_size.dart';
import 'package:web_browser/tree_view/data/ui_widgets.dart';
import 'package:web_browser/tree_view/tree_sector/child/children_tree_sector.dart';
import 'package:web_browser/tree_view/tree_sector/tree_division.dart';

final lineSectorNotifier =
    NotifierProvider.family<LineSectorNotifier, LineSector, TreeDivision>(
      () => LineSectorNotifier(),
    );

class LineSectorNotifier extends FamilyNotifier<LineSector, TreeDivision> {
  @override
  LineSector build(TreeDivision treeSector) {
    List<TreeDivisionWithSize> list = ref.watch(
      childrenSectorSizeNotifier(treeSector),
    );
    List<Offset> offsets = calcOffset(list, ref.watch(nodeHeightNotifier));
    final List<LineWidget> lines = offsets.map((offset) {
      return LineWidget(starPos: Offset(0, 0), endPos: offset);
    }).toList();
    final lineSector = LineSector(lines: lines);

    log("[build] LineSectorNotifier ${treeSector.node.name},$lines");
    state = lineSector;
    return lineSector;
  }

  List<Offset> calcOffset(List<TreeDivisionWithSize> list, double nodeHeight) {
    double sumWidth = list.fold(0, (sum, child) => sum + child.size.width);
    double dx = -sumWidth / 2;

    List<Offset> offsets = [];
    for (int i = 0; i < list.length; i++) {
      dx += (list[i].size.width) / 2;
      offsets.add(Offset(dx, nodeHeight));
      dx += (list[i].size.width) / 2;
    }
    return offsets;
  }
}

//線のウィジェット関連
/// ノード間の線を表すウィジェット
class LineSector extends StatelessWidget {
  final List<LineWidget> lines;

  const LineSector({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Stack(children: lines);
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
