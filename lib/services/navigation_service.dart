import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  NavigationService() {
    print('Navigation service initiated');
  }

  Future<dynamic> navigateTo(String routeName,
      {Object arguments, pushReplacement = false}) {
    if (pushReplacement) {
      return navigatorKey.currentState
          .pushReplacementNamed(routeName, arguments: arguments);
    }
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState.pop();
  }
}
