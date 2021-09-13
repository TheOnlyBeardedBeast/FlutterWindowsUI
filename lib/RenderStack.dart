import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'ITile.dart';
import 'Tile.dart';
import 'TileSize.dart';

typedef TileSelectionCallback = void Function(int index);

// ignore: non_constant_identifier_names
Widget RenderStack(BuildContext context,
    {List<ITile> tiles = const [],
    double spacing = 5,
    int columnCount = 6,
    TileSelectionCallback? onSelection,
    int? selectedIndex}) {
  double width = MediaQuery.of(context).size.width - 10;
  double gridUnit = ((width - ((columnCount - 1) * spacing)) / columnCount);
  bool anySelected = selectedIndex != null;

  double scaledSpacing = 3 * spacing;
  double total = 6 * gridUnit + 5 * spacing;

  double _spacing = anySelected ? scaledSpacing : spacing;
  double _gridUnit = anySelected ? (total - (5 * scaledSpacing)) / 6 : gridUnit;

  ITile maxItem = tiles.reduce((value, element) =>
      value.position.y > element.position.y ? value : element);
  double max = maxItem.position.y + (maxItem.size != TileSize.S ? 2 : 1);
  double computedHeight = (gridUnit * max) + max * spacing;

  return ListView(
    clipBehavior: Clip.none,
    children: [
      Stack(clipBehavior: Clip.none, children: <Widget>[
        Container(height: computedHeight),
        ...tiles.asMap().entries.map((entry) {
          ITile e = entry.value;

          return Tile(
              key: ValueKey(e.index),
              gridUnit: _gridUnit,
              x: e.position.x,
              y: e.position.y,
              spacing: _spacing,
              size: e.size,
              onSelection: () => onSelection!(e.index),
              selected: selectedIndex == e.index,
              anySelected: selectedIndex != null);
        }),
      ]),
      Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Text(
                "All apps",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Icon(
              PhosphorIcons.arrowRight,
              size: 30,
              color: Colors.white,
            )
          ],
        ),
      )
    ],
  );
}
