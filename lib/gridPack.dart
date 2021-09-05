import 'GridPosition.dart';
import 'ITile.dart';
import "TileSize.dart";
import "groupBy.dart";

class Bin {
  List<ITile> elements;

  Bin({this.elements = const []});

  int get weight {
    return this
        .elements
        .map((e) => e.size.weight)
        .reduce((value, element) => value + element);
  }

  add(ITile val) {
    this.elements = [...elements, val];
  }
}

List<Bin> binItems(List<ITile> tiles, {int binSize = 12}) {
  List<Bin> result = [];

  tiles.forEach((tile) {
    Bin bin = result.firstWhere((b) {
      return b.weight + tile.size.weight <= binSize;
    }, orElse: () {
      Bin res = new Bin();
      result.add(res);

      return res;
    });

    bin.add(tile);
  });

  return result;
}

List<ITile> positionItems(List<Bin> bins, {int columns = 6}) {
  List<ITile> result = [];
  bins.shuffle();
  bins.sort((a, b) => b.weight.compareTo(a.weight));

  for (int i = 0; i < bins.length; i++) {
    GridPosition nextPosition = GridPosition(x: 0, y: i * 2);
    Bin bin = bins[i];

    Map<TileSize, List<ITile>> groups = bin.elements.groupBy((e) => e.size);

    List<TileSize> workOrder = [...TileSize.values];
    workOrder.shuffle();

    for (var j = 0; j < workOrder.length; j++) {
      List<ITile> tilegroup = groups[workOrder[j]] ?? [];
      for (var k = 0; k < tilegroup.length; k++) {
        ITile element = tilegroup[k];
        element.position.x = nextPosition.x;
        element.position.y = nextPosition.y;

        switch (element.size) {
          case TileSize.S:
            nextPosition.x = (nextPosition.y - i * 2) == 1
                ? nextPosition.x += 1
                : nextPosition.x = nextPosition.x;
            nextPosition.y = (nextPosition.y - i * 2) == 1
                ? nextPosition.y = i * 2
                : nextPosition.y = i * 2 + 1;
            break;
          case TileSize.L:
            nextPosition.x += 4;
            nextPosition.y = i * 2;
            break;
          case TileSize.M:
          default:
            nextPosition.x += 2;
            nextPosition.y = i * 2;
            break;
        }

        result.add(element);
      }
    }
  }

  return result;
}

List<ITile> packItems(List<ITile> tiles) {
  return positionItems(binItems(tiles));
}
