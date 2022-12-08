import 'package:flutter/material.dart';

class ResponsiveViewLayout extends StatelessWidget {
  final Widget? mobileScaffold;
  final Widget? tableScaffold;
  final Widget? desktopScaffold;
  const ResponsiveViewLayout(
      {Key? key, this.mobileScaffold, this.tableScaffold, this.desktopScaffold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return mobileScaffold!;
      } else if (constraints.maxWidth < 1100) {
        return tableScaffold!;
      } else {
        return desktopScaffold!;
      }
    });
  }
}
