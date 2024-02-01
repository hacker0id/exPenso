import 'dart:async';

import 'package:expenso/main.dart';
import 'package:expenso/screens/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const MainPage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    device = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GifView.asset(
          'assets/gif/Splash.gif',
          height: device.height, // Replace with your actual GIF image path
        ),
      ),
    );
  }
}
