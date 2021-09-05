import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'TileSize.dart';

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
