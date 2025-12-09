import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/domain/productViewModel.dart';
import 'package:florist/utils/myTheme.dart';
import 'package:florist/views/common_widgets/appBar.dart';
import 'package:florist/views/common_widgets/dropDownHomeMenu.dart';
import 'package:florist/views/common_widgets/flower_product_card.dart';
import 'common_widgets/carousel.dart';
import 'package:get/get.dart';
import 'common_widgets/categories_view.dart';
import 'common_widgets/see_all_view.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  final ProductViewModel productViewModel = Get.find<ProductViewModel>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: MyAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            child: DropDownMenu(),
          ),
          leadingWidth: MediaQuery.of(context).size.width * 2 / 4,
          title: Row(
            children: <Widget>[
              SizedBox(width: 12),
              Icon(Icons.delivery_dining, color: Colors.redAccent),
              SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Free delivery',
                    style: TextStyle(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '2000da +',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            ThemeSwitcher(
                clipper: ThemeSwitcherCircleClipper(),
                builder: (context) {
                  return InkResponse(
                    onTap: () {
                      ThemeSwitcher.of(context).changeTheme(
                          theme: Get.isDarkMode
                              ? AppThemes.lightTheme1
                              : AppThemes.darkTheme2,
                          isReversed: Get.isDarkMode ? false : true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CircleAvatar(
                        child: Image.asset(
                          Assets.imagesUser,
                          scale: 4,
                        ),
                      ),
                    ),
                  );
                }),
          ]),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(children: [
          // Search
          Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                  readOnly: true,
                  onTap: () => Get.toNamed('/search'),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Color.fromARGB(255, 219, 219, 219)),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: "What are u looking for ?",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: Color.fromARGB(255, 224, 132, 154),
                      ),
                      suffixIcon: InkWell(
                        onTap: () => Get.toNamed("/ArExperience"),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Icon(
                            CupertinoIcons.camera,
                            color: Color.fromARGB(255, 193, 193, 193),
                          ),
                        ),
                      )))),

          // Carousel
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Carousel()),

          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SeeAllView(
              context: context,
              name: "Categories 🛍️",
              onTapAction: () => Get.toNamed("/dashboard", arguments: 1),
            ),
          ),
          SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    CategoriesView(
                        imagePath: Assets.imagesFish,
                        catName: "Seafood",
                        context: context),
                    CategoriesView(
                        imagePath: Assets.imagesFalafel,
                        catName: "Vegetables",
                        context: context),
                    CategoriesView(
                        imagePath: Assets.imagesBanana,
                        catName: "Fruits",
                        context: context),
                    CategoriesView(
                        imagePath: Assets.imagesIceCream,
                        catName: "Snacks",
                        context: context),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    CategoriesView(
                        imagePath: Assets.imagesDish,
                        catName: "Canned food",
                        context: context),
                    CategoriesView(
                        imagePath: Assets.imagesRice,
                        catName: "Pasta, Rice",
                        context: context),
                    CategoriesView(
                        imagePath: Assets.imagesSavon,
                        catName: "Home Supplie",
                        context: context),
                    CategoriesView(
                        imagePath: Assets.imagesMakeup,
                        catName: "Woman care",
                        context: context),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // ============================================================
          //     SECTION 1: PALING BANYAK DIBELI
          // ============================================================

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SeeAllView(
              context: context,
              name: "Paling Banyak Dibeli 🌸",
              onTapAction: () => Get.toNamed("/best-seller"),
            ),
          ),

          SizedBox(height: 12),

          // FlowerProductCard List
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              height: 230,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FlowerProductCard(
                    image: "https://i.imgur.com/SYHeu2v.jpeg",
                    name: "Bouquet Mawar Pink",
                    price: "Rp 120.000",
                    rating: 4.8,
                    onTap: () {},
                    onAddToCart: () {},
                  ),
                  FlowerProductCard(
                    image: "https://i.imgur.com/fiZQwqG.jpeg",
                    name: "Bucket Wisuda Elegan",
                    price: "Rp 150.000",
                    rating: 4.9,
                    onTap: () {},
                    onAddToCart: () {},
                  ),
                  FlowerProductCard(
                    image: "https://i.imgur.com/tjx3PqA.jpeg",
                    name: "Tulip Pastel Mix",
                    price: "Rp 175.000",
                    rating: 4.7,
                    onTap: () {},
                    onAddToCart: () {},
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 30),

          // ============================================================
          //     SECTION 2: REKOMENDASI WISUDA
          // ============================================================

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SeeAllView(
              context: context,
              name: "Rekomendasi Wisuda 🎓",
              onTapAction: () => Get.toNamed("/graduation"),
            ),
          ),

          SizedBox(height: 12),

          // FlowerProductCard List
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              height: 230,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FlowerProductCard(
                    image: "https://i.imgur.com/v7Mkt8b.jpeg",
                    name: "Bucket Wisuda Premium",
                    price: "Rp 190.000",
                    rating: 4.9,
                    onTap: () {},
                    onAddToCart: () {},
                  ),
                  FlowerProductCard(
                    image: "https://i.imgur.com/ACbnrZO.jpeg",
                    name: "Bouquet Mawar Elegan",
                    price: "Rp 130.000",
                    rating: 4.8,
                    onTap: () {},
                    onAddToCart: () {},
                  ),
                  FlowerProductCard(
                    image: "https://i.imgur.com/Bq5Vyzm.jpeg",
                    name: "Wisuda Teddy Bear Flowers",
                    price: "Rp 200.000",
                    rating: 5.0,
                    onTap: () {},
                    onAddToCart: () {},
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 40),
        ]),
      ),
    );
  }
}
