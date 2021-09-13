import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'mock.dart';

class AppSearch extends StatefulWidget {
  final void Function()? onTap;
  final AnimationController scaleController;
  final AnimationController opacityController;

  const AppSearch(
      {Key? key,
      this.onTap,
      required this.scaleController,
      required this.opacityController})
      : super(key: key);

  @override
  _AppSearchState createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  void onScale(double scale) {
    if (scale > 1) {
      widget.opacityController
          .reverse(from: 1)
          .then((value) => widget.onTap!());
      widget.scaleController.forward(from: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Scaffold(
        backgroundColor: Colors.black.withAlpha(230),
        body: GestureDetector(
          onTap: widget.onTap,
          onScaleUpdate: (detail) => onScale(detail.scale),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(40),
            child: ScaleTransition(
              scale: widget.scaleController,
              child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: [
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
      ),
    );
  }
}
