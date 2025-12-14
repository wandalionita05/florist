import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:florist/utils/routes.dart';
import 'package:florist/utils/myTheme.dart';
import 'package:florist/domain/user_controller.dart';
import 'package:florist/domain/cartViewModel.dart';
import 'package:florist/models/source/local/cart_local_storage.dart';
import 'package:florist/models/shopingCart_repo_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController(), permanent: true);

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final CartLocalStorage cartLocalStorage = CartLocalStorageImpl(
    sharedPreferences: sharedPreferences,
  );

  final cartRepository = CartRepositoryImpl(
    cartLocalStorage: cartLocalStorage,
  );

  Get.put(
    ShoppingCartViewModel(
      cartRepositoryImpl: cartRepository,
    ),
    permanent: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: AppThemes.lightTheme1,
      builder: (_, theme) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          initialRoute: '/splash',
          getPages: MyRoutes.pages,
        );
      },
    );
  }
}
