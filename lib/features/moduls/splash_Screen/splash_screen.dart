import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_simple_app/core/page_route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, PageRouteNames.login);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/splash@3x.png",
      fit: BoxFit.cover,
    );
  }
}
