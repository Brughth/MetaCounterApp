import 'package:flutter/material.dart';
import 'package:meta_counter_app/presentation/screens/home_screen/counter_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';

class AppRouter {
  static const String counter = 'counter';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case counter:
        return MaterialPageRoute(
          builder: (_) => CounterScreen(
            title: Strings.counterScreenTitle,
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
