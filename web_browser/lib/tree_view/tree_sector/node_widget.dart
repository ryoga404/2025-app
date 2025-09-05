import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/ui_widgets.dart';
import 'tree_sector.dart';

/// ノードを表すウィジェット
class NodeWidget extends ConsumerWidget {
  final String name;
  final TreeSector parentTreeSector;
  const NodeWidget({
    super.key,
    required this.name,
    required this.parentTreeSector,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Paint paint = ref.watch(nodePaintNotifier);
    final Size size = Size(
      ref.watch(nodeWidthNotifier),
      ref.watch(nodeHeightNotifier),
    );

    return SizedBox(
      height: size.height,
      width: size.width,
      child: CustomPaint(
        painter: NodePainter(nodePaint: paint, graphSize: size),
        child: Column(
          children: [
            Text(name),
            ElevatedButton(
              onPressed: () => ref
                  .read(treeChildrenNotifier(parentTreeSector).notifier)
                  .generateChildren(),
              child: const Text("Expand"),
            ),
          ],
        ),
      ),
    );
  }
}

///　NodeWidgetのペインター
class NodePainter extends CustomPainter {
  final Paint nodePaint;
  final Size graphSize;

  NodePainter({required this.nodePaint, required this.graphSize});
  @override
  void paint(Canvas canvas, Size size) {
    // ノードを描画するロジックをここに実装
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      graphSize.height / 2,
      nodePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
