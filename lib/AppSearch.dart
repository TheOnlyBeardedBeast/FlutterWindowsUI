import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'mock.dart';

class AppSearch extends StatefulWidget {
  final void Function()? onTap;

  const AppSearch({Key? key, this.onTap}) : super(key: key);

  @override
  _AppSearchState createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(240),
      body: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(40),
          child: GridView.count(crossAxisCount: 4, shrinkWrap: true, children: [
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
    );
  }
}
