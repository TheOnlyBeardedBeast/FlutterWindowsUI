import 'package:flutter/material.dart';

import 'ITile.dart';
import 'RenderStack.dart';
import 'gridPack.dart';
import 'mock.dart';

class XGrid extends StatefulWidget {
  XGrid({Key? key}) : super(key: key);

  @override
  _XGridState createState() => _XGridState();
}

class _XGridState extends State<XGrid> with TickerProviderStateMixin {
  late AnimationController _controller;

  late List<ITile> tiles = [];

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, // the SingleTickerProviderStateMixin
        duration: Duration(milliseconds: 100),
        value: 1,
        lowerBound: 0.9);
    super.initState();

    tiles = packItems(datatiles);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int? selected;

  void setSelected(int? index) {
    if (index == selected || index == null) {
      setState(() {
        selected = null;
      });
      _controller.forward();
    } else {
      setState(() {
        selected = index;
        tiles.sort((a, b) => index == a.index ? 1 : -1);
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => setSelected(null),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ScaleTransition(
                  scale: _controller,
                  child: RenderStack(context,
                      tiles: tiles,
                      selectedIndex: selected,
                      onSelection: setSelected),
                ),
              ),
            ) // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}
