import 'package:get/get.dart';
import 'package:membermanagementsystem/models/cart.dart';
import 'package:membermanagementsystem/models/product.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(Product product) {
    var existingItem =
        cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      if (existingItem.quantity < product.quantity) {
        existingItem.quantity++;
      }
    } else {
      cartItems.add(CartItem(product: product));
    }
  }

  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
  }

  void updateQuantity(Product product, int quantity) {
    var existingItem =
        cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      if (quantity > 0 && quantity <= product.quantity) {
        existingItem.quantity = quantity;
        cartItems.refresh(); // Refresh the list to update the UI
      }
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice => cartItems.fold(
      0, (sum, item) => sum + item.product.unitPrice * item.quantity);
}
