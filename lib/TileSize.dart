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

  int get height {
    switch (this) {
      case TileSize.S:
        return 1;
      case TileSize.M:
      case TileSize.L:
      default:
        return 2;
    }
  }

  int get width {
    switch (this) {
      case TileSize.S:
        return 1;
      case TileSize.M:
        return 2;
      case TileSize.L:
      default:
        return 4;
    }
  }
}
