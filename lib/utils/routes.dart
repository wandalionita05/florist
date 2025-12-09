import 'package:get/get.dart';
import 'package:florist/views/cart.dart';
import 'package:florist/views/dashboard.dart';
import 'package:florist/views/home.dart';
import 'package:florist/views/profile.dart';
import 'package:florist/views/registration.dart';
import 'package:florist/views/splash.dart';
import 'package:florist/views/vegetable_detail.dart';
import 'package:florist/views/vegetables.dart';
import 'package:florist/views/welcome.dart';
import 'package:florist/views/categories.dart';

class MyRoutes {
  static final List<GetPage> pages = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/', page: () => WelcomeScreen()),
    GetPage(name: '/registration', page: () => RegistrationScreen()),
    GetPage(name: '/dashboard', page: () => HomeScreen()),
    GetPage(name: '/home', page: () => DashboardScreen()),
    GetPage(name: '/categories', page: () => Categories()),
    GetPage(name: '/cart', page: () => CartScreen()),
    GetPage(name: '/profile', page: () => Profile()),
    GetPage(name: '/vegetables', page: () => VegetablesScreen()),
    //GetPage(name: '/search', page: () => VegetablesSearchScreen()),
    GetPage(name: '/details', page: () => VegetableDetailScreen()),
    //GetPage(name: '/ArExperience', page: () => ArExperience()),
  ];
}
