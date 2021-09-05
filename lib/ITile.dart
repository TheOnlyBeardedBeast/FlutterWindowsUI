import 'GridPosition.dart';
import 'TileSize.dart';

class ITile {
  TileSize size = TileSize.M;
  GridPosition position = GridPosition.initial();
  int index = 0;

  ITile.empty();

  ITile(this.size, this.position, this.index);
}
