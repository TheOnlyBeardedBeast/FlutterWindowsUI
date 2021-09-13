import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppGroup extends StatelessWidget {
  final List<Application> apps;
  final String header;
  final void Function()? onHeaderTap;
  const AppGroup(
      {Key? key, required this.apps, required this.header, this.onHeaderTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        height: 50.0,
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
                height: 50,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Center(
                  child: Icon(
                    PhosphorIcons.placeholder,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  apps[i].appName,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            ],
          ),
          childCount: apps.length,
        ),
      ),
    );
  }
}
