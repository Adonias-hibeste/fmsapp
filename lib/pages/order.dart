import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/CartController.dart';
import 'package:membermanagementsystem/pages/billingpage.dart';

class OrdersPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Get.toNamed('/Settings');
            },
          ),
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return Card(
                    color: Color(0xFFEFEFEF),
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      leading: Image.network(
                        item.product.images.isNotEmpty
                            ? item.product.images[0]
                            : 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons
                              .error); // Display an error icon if the image fails to load
                        },
                      ),
                      title: Text(item.product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '\$${item.product.unitPrice} x ${item.quantity}'),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (item.quantity > 1) {
                                    cartController.updateQuantity(
                                        item.product, item.quantity - 1);
                                  }
                                },
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  if (item.quantity < item.product.quantity) {
                                    cartController.updateQuantity(
                                        item.product, item.quantity + 1);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartController.removeFromCart(item.product);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Obx(() => Text(
                        'Total: \$${cartController.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          cartController.clearCart();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to BillingPage with the total amount
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BillingPage(
                                totalAmount: cartController
                                    .totalPrice, // Passing total amount
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          'Checkout',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
