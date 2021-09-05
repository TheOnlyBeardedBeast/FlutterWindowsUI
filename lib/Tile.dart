import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'TileResizeIcon.dart';
import 'TileSize.dart';

class CalculationResult {
  double width;
  double height;

  CalculationResult({required this.height, required this.width});
}

class Tile extends StatefulWidget {
  double gridUnit;
  double x;
  double y;
  TileSize size = TileSize.S;
  double spacing = 5;
  void Function()? onSelection;
  bool selected = false;
  bool anySelected = false;

  Tile(
      {Key? key,
      required this.gridUnit,
      required this.x,
      required this.y,
      this.size = TileSize.S,
      this.spacing = 5,
      this.onSelection,
      this.selected = false,
      this.anySelected = false})
      : super(key: key);

  _Tile createState() => _Tile();
}

class _Tile extends State<Tile> with TickerProviderStateMixin {
  late AnimationController _scaleController;

  @override
  void initState() {
    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 100),
        value: 1,
        lowerBound: 1,
        upperBound: 1.05); // 0.9
    super.initState();
  }

  @override
  void didUpdateWidget(Tile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.anySelected) {
      if (!widget.selected) {
        _scaleController.reverse();
      } else {
        _scaleController.forward();
      }
    } else {
      _scaleController.reverse();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  CalculationResult calculateSize() {
    double width;
    double height;

    switch (widget.size) {
      case TileSize.L:
        width = 4 * widget.gridUnit + 3 * widget.spacing;
        height = 2 * widget.gridUnit + widget.spacing;
        break;
      case TileSize.M:
        width = height = 2 * widget.gridUnit + widget.spacing;
        break;
      case TileSize.S:
      default:
        width = height = widget.gridUnit;
    }

    return CalculationResult(width: width, height: height);
  }

  @override
  Widget build(BuildContext context) {
    CalculationResult size = calculateSize();

    return AnimatedPositioned(
        left: widget.x * widget.gridUnit + ((widget.x) * widget.spacing),
        top: widget.y * widget.gridUnit + ((widget.y) * widget.spacing),
        duration: Duration(milliseconds: 100),
        child: GestureDetector(
          onLongPress: widget.onSelection,
          onTap: widget.anySelected ? widget.onSelection : null,
          child: ScaleTransition(
              scale: _scaleController,
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: widget.anySelected && !widget.selected ? 0.75 : 1,
                duration: Duration(milliseconds: 100),
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(color: Colors.blue.shade600),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                          child: Icon(
                        PhosphorIcons.placeholder,
                        size: 0.6 * widget.gridUnit,
                        color: Colors.white,
                      )),
                      if (widget.size != TileSize.S)
                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              "Application",
                              style: TextStyle(color: Colors.white),
                            )),
                      if (widget.selected) ...[
                        Positioned(
                            right: -15,
                            bottom: -15,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Center(
                                  child: Icon(
                                TileResizeIcon(widget.size),
                                color: Colors.black,
                              )),
                            )),
                        Positioned(
                            right: -15,
                            top: -15,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Center(
                                  child: Icon(
                                PhosphorIcons.pushPinSlash,
                                color: Colors.black,
                              )),
                            ))
                      ]
                    ],
                  ),
                ),
              )),
        ));
  }
}
