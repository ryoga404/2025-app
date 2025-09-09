import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_browser/tree_view/data/tree_sector_with_size.dart';
import 'package:web_browser/tree_view/tree_sector/tree_division.dart';

final childrenTreeSectorNotifier =
    NotifierProvider.family<
      ChildrenTreeSectorNotifier,
      ChildrenTreeSector,
      TreeDivision
    >(() => ChildrenTreeSectorNotifier());

class ChildrenTreeSectorNotifier
    extends FamilyNotifier<ChildrenTreeSector, TreeDivision> {
  @override
  ChildrenTreeSector build(TreeDivision treeDivision) {
    log("[build] ChildrenTreeSectorNotifier built. ${treeDivision.node.name}");
    state = ChildrenTreeSector(parent: treeDivision);
    return state;
  }
}

final childrenSectorSizeNotifier =
    NotifierProvider.family<
      ChildrenSectorSizeNotifier,
      List<TreeDivisionWithSize>,
      TreeDivision
    >(() => ChildrenSectorSizeNotifier());

class ChildrenSectorSizeNotifier
    extends FamilyNotifier<List<TreeDivisionWithSize>, TreeDivision> {
  @override
  List<TreeDivisionWithSize> build(TreeDivision arg) {
    return [];
  }

  void setSizeList(List<TreeDivisionWithSize> sectors) {
    Function isEqual = const ListEquality().equals;
    if(isEqual(sectors,state)) return;
    log("[State changed] ChildrenSectorSizeNotifier. node:${arg.node.name},value:$sectors");
    state = sectors;
  }

  void removeSize() {
    state = [];
  }
}

class ChildrenTreeSector extends HookConsumerWidget {
  const ChildrenTreeSector({super.key, required this.parent});
  final TreeDivision parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TreeDivision> children = ref.watch(treeChildrenNotifier(parent));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final List<TreeDivisionWithSize> treeSizeList = children.map((child) {
        final size = ref.watch(treeDivisionSizeNotifier(child));
        return TreeDivisionWithSize(treeSector: child, size: size);
      }).toList();

      ref
          .read(childrenSectorSizeNotifier(parent).notifier)
          .setSizeList(treeSizeList);
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
