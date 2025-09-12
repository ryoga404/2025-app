import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_browser/tree_view/tree_sector/child/children_tree_sector.dart';

import '../../node/node.dart';
import '../data/ui_widgets.dart';
import 'child/line_sector.dart';
import 'node_widget.dart';

///====TreeSectorの子要素を管理するNotifier====
///子要素を利用する際に参照。
final treeChildrenNotifier =
    NotifierProvider.family<
      TreeChildrenNotifier,
      List<TreeDivision>,
      TreeDivision
    >(() => TreeChildrenNotifier());

class TreeChildrenNotifier
    extends FamilyNotifier<List<TreeDivision>, TreeDivision> {
  @override
  List<TreeDivision> build(treeSector) {
    this.treeSector = treeSector;
    return [];
  }

  void generateChildren() {
    log(
      "State changed:TreeChildrenNotifer.[node.name = ${treeSector.node.name}]",
    );
    state = treeSector.node.children
        .map((child) => TreeDivision(key: UniqueKey(), node: child))
        .toList();
  }

  void removeChildren() {
    state = [];
  }

  late final TreeDivision treeSector;
}

//============================================

///====TreeSector自身のsizeを公開するNotifier>====
final treeDivisionSizeNotifier =
    NotifierProvider.family<TreeDivisonSizeNotifier, Size, TreeDivision>(
      () => TreeDivisonSizeNotifier(),
    );

class TreeDivisonSizeNotifier extends FamilyNotifier<Size, TreeDivision> {
  @override
  Size build(TreeDivision treeSector) {
    return Size(0, 0);
  }

  void update(Size size) {
    if (state == size) return;
    state = size;
  }
}

//==============================================

/// ツリー構造のセクターを表すウィジェット
class TreeDivision extends HookConsumerWidget {
  //自身に対応しているノード
  final Node node;
  //自身が描画しているNodeWidget
  late final NodeWidget nodeWidget = NodeWidget(
    key: UniqueKey(),
    name: node.name,
    parentTreeSector: this,
  );
  bool isExpanded = false;

  ///`node`:入力されたNodeの`name`プロパティを表示する。
  TreeDivision({required super.key, required this.node});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double verticalInterval = ref.watch(verticalIntervalNotifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = context.findRenderObject() as RenderBox;
      Size mySize = renderBox.size;
      log("Render Complete!. ${node.name}");
      ref.read(treeDivisionSizeNotifier(this).notifier).update(mySize);
    });

    final childrenTreeSector = ref.watch(childrenTreeSectorNotifier(this));
    final lineSector = SizedBox(
      height: verticalInterval,
      child: ref.watch(lineSectorNotifier(this)),
    );

    //１セクタは３階層で表示。
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        //自身のノード
        nodeWidget,
        //子ノードへの線
        lineSector,
        //子セクターたち
        childrenTreeSector,
      ],
    );
  }

  LineSector generateLineSector(List<Offset> childrenPos) {
    List<LineWidget> newLines = [];
    for (Offset childPos in childrenPos) {
      LineWidget line = LineWidget(starPos: Offset(0, 0), endPos: childPos);
      newLines.add(line);
    }
    return LineSector(lines: newLines);
  }

  ///子ノードへ続く線の終点を計算するメソッド
}
