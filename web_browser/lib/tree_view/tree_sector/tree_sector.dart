
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_browser/tree_view/tree_sector/child/children_tree_sector.dart';

import '../../node/node.dart';
import '../data/ui_widgets.dart';
import 'child/line_sector.dart';
import 'node_widget.dart';

///====TreeSectorの子要素を管理するNotifier====
///子要素を利用する際に参照。
final treeChildrenNotifier =
    NotifierProvider.family<TreeChildrenNotifier, List<TreeSector>, TreeSector>(
      () => TreeChildrenNotifier(),
    );

class TreeChildrenNotifier extends FamilyNotifier<List<TreeSector>, TreeSector> {
  @override
  List<TreeSector> build(treeSector) {
    this.treeSector = treeSector;
    return [];
  }

  void generateChildren(){
    state = treeSector.node.children.map((child)=>TreeSector(key: UniqueKey(), node: child)).toList();
  }

  void removeChildren(){
    state =[];
  }

  late final TreeSector treeSector;
}

//============================================




///====TreeSector自身のsizeを公開するNotifier>====
final treeSectorSizeNotifer = NotifierProvider.family<TreeSectorSizeNotifer,Size,TreeSector>(() => TreeSectorSizeNotifer());

class TreeSectorSizeNotifer extends FamilyNotifier<Size,TreeSector> {
  @override
  Size build(TreeSector treeSector) {
    return Size(0, 0);
  }

  void update(Size size){
    state = size;
  }
  
}

//==============================================

/// ツリー構造のセクターを表すウィジェット
/// 
/// 
class TreeSector extends HookConsumerWidget {
  //自身に対応しているノード
  final Node node;
  //自身が描画しているNodeWidget
  late final NodeWidget nodeWidget = NodeWidget(
    key: UniqueKey(),
    name: node.name,
    parentTreeSector: this,
  );

  ///`node`:入力されたNodeの`name`プロパティを表示する。
  TreeSector({required super.key, required this.node});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineWidget = useState(LineSector(lines: []));
    final double verticalInterval = ref.watch(verticalIntervalNotifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = context.findRenderObject() as RenderBox;
      Size mySize = renderBox.size;
      ref.read(treeSectorSizeNotifer(this).notifier).update(mySize);
    });


    //１セクタは３階層で表示。
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        //自身のノード
        nodeWidget,
        //子ノードへの線
        SizedBox(height: verticalInterval, child: lineWidget.value),
        //子セクターたち
        ChildrenTreeSector(parent: this),
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
