import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midev_system_fl/animated_loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: _mainPage());
  }

  _mainPage() {
    return const AnimatedLoading();
    // return const Landing();
  }
}
