import 'package:car_rental/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ((context, child) {
        return ResponsiveWrapper.builder(child,
            maxWidth: 1500,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
            background: Container(color: Colors.white));
      }),
      title: 'Motorpool',
      home: const HomeScreen(),
    );
  }
}
