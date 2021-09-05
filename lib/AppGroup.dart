import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppGroup extends StatelessWidget {
  final List<String> apps;
  final String header;
  final void Function()? onHeaderTap;
  const AppGroup(
      {Key? key, required this.apps, required this.header, this.onHeaderTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        height: 60.0,
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: onHeaderTap,
          child: Container(
            child: Text(
              header.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => Row(
            children: [
              Container(
                color: Colors.blue,
                height: 40,
                width: 40,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Icon(
                    PhosphorIcons.placeholder,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Text(
                apps[i].substring(0, 1).toUpperCase() + apps[i].substring(1),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          childCount: apps.length,
        ),
      ),
    );
  }
}
