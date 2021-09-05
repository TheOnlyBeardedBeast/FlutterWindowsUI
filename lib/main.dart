import 'package:flutter/material.dart';

import 'AppList.dart';
import 'XGrid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WindowsPages(),
    );
  }
}

class WindowsPages extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [XGrid(), AppList()],
      scrollDirection: Axis.horizontal,
    );
  }
}
