import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:florist/views/profile.dart';
import 'package:florist/views/dashboard.dart';
import 'package:florist/views/cart.dart';
import 'package:florist/views/search.dart';
import 'package:florist/domain/cartViewModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final RxInt _currentIndex = 0.obs;
  final ShoppingCartViewModel shoppingCart = Get.find<ShoppingCartViewModel>();
  late final PageController _pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController(initialPage: _currentIndex.value);
    shoppingCart.getCartItemList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ThemeSwitchingArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            _currentIndex.value = index;
          },
          children: [
            DashboardScreen(),
            SearchScreen(),
            CartScreen(),
            Profile(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    shoppingCart.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      await shoppingCart.persistCartItems();
    }
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _currentIndex.value,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        selectedItemColor: const Color(0xFFE0849A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavigationBarItem(
            _currentIndex.value == 0 ? Icons.home_rounded : Icons.home_outlined,
            "Home",
          ),
          _buildBottomNavigationBarItem(
            CupertinoIcons.search,
            "Search",
          ),
          _buildCartNavigationBarItem(),
          _buildBottomNavigationBarItem(
            _currentIndex.value == 3 ? Icons.settings : Icons.settings_outlined,
            "Settings",
          ),
        ],
      );
    });
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  BottomNavigationBarItem _buildCartNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: StreamBuilder<int>(
        stream: shoppingCart.cartUpdates,
        builder: (context, snapshot) {
          final int cartUpdates = snapshot.data ?? 0;

          return cartUpdates > 0
              ? badges.Badge(
                  badgeContent: Text(
                    cartUpdates.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  position: badges.BadgePosition.topEnd(top: -10, end: -10),
                  child: const Icon(Icons.shopping_cart_rounded),
                )
              : const Icon(Icons.shopping_cart_outlined);
        },
      ),
      label: "Cart",
    );
  }
}
