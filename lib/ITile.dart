import 'GridPosition.dart';
import 'TileSize.dart';

class ITile {
  TileSize size = TileSize.M;
  GridPosition position = GridPosition.initial();
  int index = 0;

  ITile.empty();

  ITile(this.size, this.position, this.index);

  int get height {
    return this.size.height;
  }

  int get width {
    return this.size.width;
  }

  GridPosition get endPosition {
    return GridPosition(
        x: this.position.x + this.width, y: this.position.y + this.height);
  }

  List<double> get xRange {
    return List<double>.generate(this.width, (index) => index + position.x);
  }

  List<double> get yRange {
    return List<double>.generate(this.height, (index) => index + position.y);
  }
}
