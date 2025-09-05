import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_browser/tree_view/data/tree_sector_with_size.dart';
import 'package:web_browser/tree_view/tree_sector/tree_sector.dart';

class ChildrenTreeSector extends HookConsumerWidget {
  const ChildrenTreeSector({super.key, required this.parent});
  final TreeSector parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<TreeSector> children = ref.watch(treeChildrenNotifier(parent));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final List<TreeSectorWithSize> treeSizeList = children.map((child){
        final size = ref.read(treeSectorSizeNotifer(child));
        return TreeSectorWithSize(child, size);
        }).toList();

      ref.read(childrenSectorSizeNotifier(parent).notifier).setSizeList(treeSizeList);
    });

    return Row(children: children);
  }

  
}



final childrenSectorSizeNotifier =
    NotifierProvider.family<
      ChildrenSectorSizeNotifer,
      List<TreeSectorWithSize>,
      TreeSector
    >(() => ChildrenSectorSizeNotifer());

class ChildrenSectorSizeNotifer
    extends FamilyNotifier<List<TreeSectorWithSize>, TreeSector> {
  @override
  List<TreeSectorWithSize> build(TreeSector arg) {
    return [];
  }

  void setSizeList(List<TreeSectorWithSize> sectors) {
    state = sectors;
  }

  void removeSize() {
    state = [];
  }
}
