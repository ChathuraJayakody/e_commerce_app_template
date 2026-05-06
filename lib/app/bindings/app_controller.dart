import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/product_model.dart';

class AppController extends GetxController {
  // Theme
  final RxBool isDarkMode = false.obs;

  // Bottom Nav
  final RxInt currentNavIndex = 0.obs;

  // Cart
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  // Wishlist
  final RxList<String> wishlistIds = <String>[].obs;

  // Auth State
  final RxBool isLoggedIn = false.obs;

  // Notification count
  final RxInt notificationCount = 3.obs;

  // Currency
  final RxString currency = '\$'.obs;
  final RxString locale = 'en'.obs;

  void toggleDarkMode() => isDarkMode.toggle();

  void setNavIndex(int index) => currentNavIndex.value = index;

  // Cart Operations
  void addToCart(ProductModel product, {String? color, String? size, int qty = 1}) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id && item.color == color && item.size == size,
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: cartItems[existingIndex].quantity + qty,
      );
    } else {
      cartItems.add(CartItem(
        product: product,
        color: color ?? product.colors.first,
        size: size ?? product.sizes.first,
        quantity: qty,
      ));
    }

    Get.snackbar(
      'Added to Cart',
      '${product.name} added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1A3C8F),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void removeFromCart(int index) => cartItems.removeAt(index);

  void updateCartQuantity(int index, int qty) {
    if (qty <= 0) {
      removeFromCart(index);
    } else {
      cartItems[index] = cartItems[index].copyWith(quantity: qty);
    }
  }

  void clearCart() => cartItems.clear();

  int get cartCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get cartTotal => cartItems.fold(
      0.0, (sum, item) => sum + item.product.price * item.quantity);

  double get cartDiscount => cartItems.fold(
      0.0,
      (sum, item) =>
          sum + (item.product.originalPrice - item.product.price) * item.quantity);

  // Wishlist Operations
  void toggleWishlist(String productId) {
    if (wishlistIds.contains(productId)) {
      wishlistIds.remove(productId);
    } else {
      wishlistIds.add(productId);
    }
  }

  bool isInWishlist(String productId) => wishlistIds.contains(productId);

  List<ProductModel> get wishlistProducts => DummyData.products
      .where((p) => wishlistIds.contains(p.id))
      .toList();
}

class CartItem {
  final ProductModel product;
  final String color;
  final String size;
  final int quantity;

  const CartItem({
    required this.product,
    required this.color,
    required this.size,
    required this.quantity,
  });

  CartItem copyWith({
    ProductModel? product,
    String? color,
    String? size,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}
