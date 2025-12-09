import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/views/welcome.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () => Get.offAll(() => const WelcomeScreen()),
    );

    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Center(
        child: Image.asset(
          Assets.imagesAppIcon,
          scale: 2.5,
        ),
      ),
    );
  }
}
