import 'package:flutter/material.dart';
import 'package:florist/utils/routes.dart';
import 'package:florist/utils/helper.dart';
import 'package:florist/utils/myTheme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: AppThemes.lightTheme1,
        builder: (context, myTheme) {
          return GetMaterialApp(
            title: "florist",
            theme: myTheme,
            initialRoute: "/splash",
            getPages: MyRoutes.pages,
          );
        });
  }
}
