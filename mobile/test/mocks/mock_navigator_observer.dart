import 'package:flutter/material.dart';

class MockNavigatorObserver extends NavigatorObserver {
  List<Route> pushedRoutes = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    pushedRoutes.add(route);
  }
}
