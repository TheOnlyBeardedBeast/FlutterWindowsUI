import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wingrid/GestureScrollView.dart';

import 'AppGroup.dart';
import 'AppSearch.dart';
import 'mock.dart';
import "groupBy.dart";

class AppList extends StatefulWidget {
  const AppList({Key? key}) : super(key: key);

  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> with TickerProviderStateMixin {
  late AnimationController _opacityController;
  late AnimationController _scaleController;
  final ScrollController _scrollController = new ScrollController();

  bool didStartScale = false;
  double? updatedScale;

  @override
  void initState() {
    _opacityController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 200), value: 0);

    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        value: 2,
        lowerBound: 1,
        upperBound: 2);
    super.initState();
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  bool visible = false;

  void toggleVisibility() {
    setState(() {
      visible = !visible;
      _opacityController.forward();
      _scaleController.reverse();
    });
  }

  void onSearchTap() {
    _scaleController.forward();
    _opacityController.reverse().then((value) {
      setState(() {
        visible = !visible;
      });
    });
  }

  void onScale(double scale) {
    if (!visible && scale < 1) {
      toggleVisibility();
      _opacityController.forward(from: 1 - scale);
      _scaleController.reverse(from: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    appData.sort((a, b) => a.compareTo(b));

    return Stack(children: [
      GestureDetector(
          onScaleUpdate: (details) => onScale(details.scale),
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, height: 1.5),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: Icon(
                            PhosphorIcons.magnifyingGlass,
                            color: Colors.grey,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureCustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          ...appData
                              .groupBy((e) => e.substring(0, 1))
                              .values
                              .map((value) => AppGroup(
                                  onHeaderTap: () =>
                                      toggleVisibility(), //() => _scrollController.jumpTo(value),
                                  apps: value,
                                  header: value[0].substring(0, 1)))
                        ],
                      ),
                    ),
                  ],
                ) // This trailing comma makes auto-formatting nicer for build methods.
                ),
          )),
      Visibility(
        visible: visible,
        child: FadeTransition(
          opacity: _opacityController,
          child: AppSearch(
            onTap: onSearchTap,
            scaleController: _scaleController,
            opacityController: _opacityController,
          ),
        ),
      )
    ]);
  }
}
