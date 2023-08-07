import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> push<T extends Object?>(Widget page) {
    return navigatorKey.currentState!.push(
      PageTransition(child: page, type: PageTransitionType.rightToLeft),
    );
  }

  void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState!.pop(result);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(Widget page) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      PageTransition(child: page, type: PageTransitionType.rightToLeft),
      (route) => false,
    );
  }
}
