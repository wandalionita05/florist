import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:florist/constants/assets.dart';
import 'package:florist/domain/cartViewModel.dart';
import 'package:florist/utils/helper.dart';
import 'package:florist/views/common_widgets/appBar.dart';
import 'package:lottie/lottie.dart';
import 'common_widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final ShoppingCartViewModel cartViewModel = Get.find<ShoppingCartViewModel>();
  static const int minimumOrderValue = 120000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: Center(
          child: Text(
            "Cart 🛒",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                final cartItems = cartViewModel.productCartMap.values.toList();

                if (cartItems.isEmpty) {
                  return Center(
                    child: Image.asset(
                      Assets.imagesEmptyCart,
                      width: 280,
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: Color(0xffF1F1F5)),
                  itemBuilder: (context, index) {
                    return CartItemWidget(item: cartItems[index]);
                  },
                );
              }),
            ),
          ),
          Obx(() {
            final cartItems = cartViewModel.productCartMap.values.toList();

            final int totalPrice = cartItems.fold<int>(
              0,
              (sum, item) =>
                  sum + (int.parse(item.price ?? "0") * item.itemQuantity),
            );

            final bool canCheckout = totalPrice >= minimumOrderValue;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    canCheckout
                        ? "Minimum order reached 🎉"
                        : "Add ${_formatRupiah(minimumOrderValue - totalPrice)} more to meet the minimum order",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: canCheckout ? Colors.green : Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total price",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatRupiah(totalPrice),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: canCheckout
                              ? () {
                                  Get.dialog(
                                    Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Thanks for checking out!",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Lottie.asset(
                                              Assets.imagesDeveloperCoffe,
                                              width: 220,
                                              repeat: false,
                                              decoder: customDecoder,
                                            ),
                                            const SizedBox(height: 12),
                                            ElevatedButton(
                                              onPressed: () => Get.back(),
                                              child: const Text("Close"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: canCheckout
                                ? Get.theme.primaryColor
                                : Colors.grey,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatRupiah(int value) {
    return "Rp ${value.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
        )}";
  }
}
