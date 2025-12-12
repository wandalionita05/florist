import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/domain/cartViewModel.dart';
import 'package:florist/models/dto/cart.dart';
import 'package:florist/models/dto/product.dart';
import 'package:florist/views/common_widgets/appBar.dart';
import 'package:florist/views/common_widgets/search_text_field.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'common_widgets/item_key_points_view.dart';

class VegetableDetailScreen extends StatefulWidget {
  const VegetableDetailScreen({Key? key}) : super(key: key);

  @override
  State<VegetableDetailScreen> createState() => _VegetableDetailScreenState();
}

class _VegetableDetailScreenState extends State<VegetableDetailScreen> {
  final ShoppingCartViewModel cartViewModel = Get.find<ShoppingCartViewModel>();
  final Product product = Get.arguments;

  late final List<CachedNetworkImageProvider> multiImageProvider;

  @override
  void initState() {
    super.initState();

    /// ✅ FILTER URL AMAN
    multiImageProvider = [];

    if (product.imagefronturl != null &&
        product.imagefronturl!.isNotEmpty &&
        product.imagefronturl!.startsWith('http')) {
      multiImageProvider
          .add(CachedNetworkImageProvider(product.imagefronturl!));
    }

    if (product.imagenutritionurl != null &&
        product.imagenutritionurl!.isNotEmpty &&
        product.imagenutritionurl!.startsWith('http')) {
      multiImageProvider
          .add(CachedNetworkImageProvider(product.imagenutritionurl!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: const SearchTextField(
          hint: "What are u looking for ?",
          readOnly: true,
        ),
        leading: InkResponse(
          onTap: () => Get.back(),
          child: const BackButtonIcon(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.favorite_border_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkResponse(
                    onTap: () {
                      if (multiImageProvider.isEmpty) return;

                      Get.to(() => PhotoViewGallery.builder(
                            itemCount: multiImageProvider.length,
                            builder: (context, index) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: multiImageProvider[index],
                                heroAttributes: PhotoViewHeroAttributes(
                                  tag: product.id ?? "",
                                ),
                              );
                            },
                          ));
                    },
                    child: Hero(
                      tag: product.id ?? "",
                      child: CachedNetworkImage(
                        imageUrl: product.imagefronturl ?? '',
                        height: 200,
                        fit: BoxFit.contain,
                        placeholder: (_, __) =>
                            const CircularProgressIndicator(),
                        errorWidget: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.price ?? "0"} / ${product.quantity}",
                          style: const TextStyle(
                            color: Color(0xffFF324B),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(product.productname ?? "-"),
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            ItemKeyPointsView(
                              imagePath: Assets.imagesOrganic,
                              title: "100%",
                              desc: "Organic",
                            ),
                            SizedBox(width: 8),
                            ItemKeyPointsView(
                              imagePath: Assets.imagesHouse,
                              title: "1 Year",
                              desc: "Expiration",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ================= CART ACTION =================
          Container(
            padding: const EdgeInsets.all(16),
            color: Get.theme.cardColor.withOpacity(0.9),
            child: Obx(() {
              final cartItem =
                  cartViewModel.productCartMap[product.id.toString()];
              return cartItem != null
                  ? _buildCartActions(cartItem)
                  : _buildAddToCartButton();
            }),
          ),
        ],
      ),
    );
  }

  /// ================= ADD TO CART (FIXED) =================
  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: () {
        cartViewModel.addToCart(
          CartItem(
            id: product.id,
            imagefrontsmallurl:
                product.imagefrontsmallurl ?? product.imagefronturl ?? '',
            imagefronturl: product.imagefronturl ?? '',
            productname: product.productname,
            quantity: product.quantity,
            price: product.price,
            categories: product.categories,
            itemQuantity: 1,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Get.theme.primaryColor,
        shape: const StadiumBorder(),
      ),
      child: const Text("Add to cart"),
    );
  }

  Widget _buildCartActions(CartItem cartItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => cartViewModel.removeFromCart(cartItem),
        ),
        Text(
          cartItem.itemQuantity.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => cartViewModel.addToCart(cartItem),
        ),
      ],
    );
  }
}
