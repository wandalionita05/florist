import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/utils/myTheme.dart';
import 'package:florist/views/common_widgets/appBar.dart';
import 'package:florist/views/common_widgets/flower_product_card.dart';
import 'package:florist/views/common_widgets/carousel.dart';

import 'package:florist/domain/cartViewModel.dart';
import 'package:florist/models/dto/cart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _searchController = TextEditingController();
  final ShoppingCartViewModel cartVM = Get.find<ShoppingCartViewModel>();
  final List<Map<String, dynamic>> _allProducts = [
    {
      "image":
          "https://cdn.pixabay.com/photo/2014/07/14/11/44/bridal-393049_1280.jpg",
      "name": "Wedding Bucket",
      "price": "Rp 120.000",
      "rating": 4.8,
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2025/03/26/09/05/postcard-9494030_1280.jpg",
      "name": "Bucket Wisuda + Boneka",
      "price": "Rp 150.000",
      "rating": 4.9,
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2016/05/27/22/25/roses-1420719_1280.jpg",
      "name": "Bucket Mawar Elegan",
      "price": "Rp 130.000",
      "rating": 4.8,
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2018/07/17/21/49/flower-bouquet-3545096_1280.jpg",
      "name": "Bucket Wisuda Premium",
      "price": "Rp 190.000",
      "rating": 4.9,
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2020/02/11/10/20/bouquet-4839049_1280.jpg",
      "name": "Wisuda Bucket Buah",
      "price": "Rp 200.000",
      "rating": 5.0,
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR28bhFZx_Nf-vl_AUhdXDJ4eusEeS_daWzqg&s",
      "name": "Bucket Mawar Pink",
      "price": "Rp 140.000",
      "rating": 4.7,
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqhM7CJGv4K4o9U-u86o5VhXy1jIJmdHAyBg&s",
      "name": "Bucket Anniversary",
      "price": "Rp 160.000",
      "rating": 4.8,
    },
    {
      "image":
          "https://img.lazcdn.com/g/ff/kf/Sdf7874be8ad44d098e98b8a2e83036402.jpg_720x720q80.jpg",
      "name": "Bucket Ulang Tahun",
      "price": "Rp 135.000",
      "rating": 4.6,
    },
    {
      "image":
          "https://img.lazcdn.com/g/ff/kf/Sf73b0ea8b6d945afb983ce3db5c87dfav.jpg_720x720q80.jpg",
      "name": "Bucket Mawar Putih",
      "price": "Rp 155.000",
      "rating": 4.8,
    },
    {
      "image":
          "https://media.karousell.com/media/photos/products/2025/2/11/buket_pita_satin_for_wisuda_1739273279_7de5febe.jpg",
      "name": "Bucket Bunga Satin",
      "price": "Rp 125.000",
      "rating": 4.5,
    },
  ];

  late List<Map<String, dynamic>> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(_allProducts);
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = List.from(_allProducts);
      } else {
        _filteredProducts = _allProducts
            .where((product) => (product["name"] as String)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Stack(
          alignment: Alignment.center,
          children: const [
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_florist,
                    size: 22,
                    color: Color(0xFFE0849A),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Florist · Free delivery',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ThemeSwitcher(
            clipper: ThemeSwitcherCircleClipper(),
            builder: (context) {
              return InkWell(
                onTap: () {
                  ThemeSwitcher.of(context).changeTheme(
                    theme: Get.isDarkMode
                        ? AppThemes.lightTheme1
                        : AppThemes.darkTheme2,
                    isReversed: !Get.isDarkMode,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundColor: Colors.pink.shade100,
                    child: Image.asset(
                      Assets.imagesUser,
                      scale: 4,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: "What are you looking for?",
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Color(0xFFE0849A),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Carousel(),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Trends",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _productList(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _productList() {
    return SizedBox(
      height: 230,
      child: _filteredProducts.isEmpty
          ? const Center(
              child: Text(
                "Produk tidak ditemukan 😢",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return FlowerProductCard(
                  image: product["image"],
                  name: product["name"],
                  price: product["price"],
                  rating: product["rating"],
                  onTap: () {},
                  onAddToCart: () {
                    final CartItem cartItem = CartItem(
                      id: product["name"],
                      imagefrontsmallurl: product["image"],
                      imagefronturl: product["image"],
                      productname: product["name"],
                      quantity: "1",
                      price: _onlyNumber(product["price"]),
                      categories: "trends",
                      itemQuantity: 1,
                    );

                    cartVM.addToCart(cartItem);

                    Get.snackbar(
                      "Cart",
                      "${product["name"]} ditambahkan",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.pink.shade100,
                      colorText: Colors.black,
                    );
                  },
                );
              },
            ),
    );
  }

  String _onlyNumber(String rawPrice) {
    return rawPrice
        .replaceAll("Rp", "")
        .replaceAll(".", "")
        .replaceAll(" ", "")
        .trim();
  }
}
