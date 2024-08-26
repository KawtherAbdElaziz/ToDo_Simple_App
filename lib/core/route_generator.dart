import 'package:flutter/material.dart';
import 'package:todo_simple_app/core/page_route_names.dart';
import 'package:todo_simple_app/features/moduls/layout/lay_out.dart';
import 'package:todo_simple_app/features/moduls/login/login.dart';
import 'package:todo_simple_app/features/moduls/registeration/registeration.dart';
import 'package:todo_simple_app/features/moduls/settings/settings.dart';
import 'package:todo_simple_app/features/moduls/splash_Screen/splash_screen.dart';
import 'package:todo_simple_app/features/moduls/tasks/tasks.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteNames.initial:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen(), settings: settings);

      case PageRouteNames.layout:
        return MaterialPageRoute(
            builder: (context) => const LayOut(), settings: settings);
      case PageRouteNames.login:
        return MaterialPageRoute(
            builder: (context) => const Login(), settings: settings);
      case PageRouteNames.registeration:
        return MaterialPageRoute(
            builder: (context) => const Registeration(), settings: settings);
      case PageRouteNames.settings:
        return MaterialPageRoute(
            builder: (context) => const Settings(), settings: settings);
      case PageRouteNames.tasks:
        return MaterialPageRoute(
            builder: (context) => const Tasks(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen(), settings: settings);
    }
  }
}
