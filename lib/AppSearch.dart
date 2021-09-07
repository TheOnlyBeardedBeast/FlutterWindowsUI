import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'mock.dart';

class AppSearch extends StatefulWidget {
  final void Function()? onTap;
  final AnimationController scaleController;

  const AppSearch({Key? key, this.onTap, required this.scaleController})
      : super(key: key);

  @override
  _AppSearchState createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  void onScale(double scale) {
    if (scale > 1) {
      widget.scaleController.reverse(from: 1).then((value) => widget.onTap!());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(240),
      body: GestureDetector(
        onTap: widget.onTap,
        onScaleUpdate: (detail) => onScale(detail.scale),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          child: ScaleTransition(
            scale: widget.scaleController,
            child:
                GridView.count(crossAxisCount: 4, shrinkWrap: true, children: [
              ...gridData.map((e) => Center(
                    child: Text(
                      e,
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  )),
              Icon(
                PhosphorIcons.globe,
                size: 32,
                color: Colors.white,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
