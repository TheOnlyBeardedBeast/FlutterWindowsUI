enum TileSize { S, M, L }

extension TileSizeExtension on TileSize {
  int get weight {
    switch (this) {
      case TileSize.S:
        return 1;
      case TileSize.M:
        return 4;
      case TileSize.L:
      default:
        return 8;
    }
  }
}
