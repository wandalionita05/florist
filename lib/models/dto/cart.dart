import 'dart:convert';
import 'package:florist/models/dto/product.dart';

class CartItem extends Product {
  int itemQuantity;

  CartItem({
    required String? id,
    required String? imagefrontsmallurl,
    required String? imagefronturl,
    required String? productname,
    required String? quantity,
    required String? price,
    required String? categories,
    required this.itemQuantity,
  }) : super(
          id: id,
          imagefrontsmallurl: imagefrontsmallurl,
          imagefronturl: imagefronturl,
          productname: productname,
          quantity: quantity,
          price: price,
          categories: categories,
        );

  // ---------------- JSON ----------------

  factory CartItem.fromRawJson(String str) =>
      CartItem.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory CartItem.fromMap(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      imagefrontsmallurl: json['image_front_small_url'],
      imagefronturl: json['imagefronturl'],
      productname: json['product_name'],
      quantity: json['quantity'],
      price: json['price'],
      itemQuantity: json['itemQuantity'],
      categories: json['categories'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image_front_small_url': imagefrontsmallurl,
      'imagefronturl': imagefronturl,
      'product_name': productname,
      'quantity': quantity,
      'price': price,
      'itemQuantity': itemQuantity,
      'categories': categories,
    };
  }
}
