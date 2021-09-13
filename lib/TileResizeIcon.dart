import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'TileSize.dart';

// ignore: non_constant_identifier_names
PhosphorIconData TileResizeIcon(TileSize size) {
  switch (size) {
    case TileSize.L:
      return PhosphorIcons.arrowLeft;
    case TileSize.M:
      return PhosphorIcons.arrowUpLeft;
    case TileSize.S:
    default:
      return PhosphorIcons.arrowDownRight;
  }
}
