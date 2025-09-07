import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_browser/tree_view/tree_sector/tree_division.dart';

part 'tree_sector_with_size.freezed.dart';

@freezed
abstract class TreeDivisionWithSize with _$TreeSectorWithSize {
  const factory TreeDivisionWithSize({
    required TreeDivision treeSector,
    required Size size,
  }) = _TreeSectorWithSize;
}
