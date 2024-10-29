import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/Apiservice.dart';
import 'package:membermanagementsystem/controllers/CartController.dart';
import 'package:membermanagementsystem/models/category.dart';
import 'package:membermanagementsystem/models/product.dart';
import 'package:membermanagementsystem/pages/blogs.dart';
import 'package:membermanagementsystem/pages/events.dart';
import 'package:membermanagementsystem/pages/news.dart';
import 'package:membermanagementsystem/pages/order.dart';
import 'package:membermanagementsystem/pages/payments.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<Category> categories = [];
  List<Product> products = [];
  int _selectedIndex = 0;
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    ApiService apiService = ApiService();
    categories = await apiService.fetchCategories();
    products = await apiService.fetchProducts();
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    void _setStatusBarColor() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFF003049), // Set the status bar color
        statusBarIconBrightness:
            Brightness.light, // Set the status bar icon color
      ));
    }

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Blogs()),
        ).then((_) => _setStatusBarColor());
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Events()),
        ).then((_) => _setStatusBarColor());
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => News()),
        ).then((_) => _setStatusBarColor());
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Store()),
        ).then((_) => _setStatusBarColor());
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentFormPage()),
        ).then((_) => _setStatusBarColor());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: Text(
          "Store",
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
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 0, end: 3),
                  badgeContent: Text(
                    '${cartController.cartItems.length}',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF003049),
                    ),
                    onPressed: () {
                      Get.to(() => OrdersPage());
                    },
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => OrdersPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF003049),
                  ),
                  child: Text(
                    'View Orders',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: categories.map((category) {
                List<Product> categoryProducts = products
                    .where((product) => product.categoryId == category.id)
                    .toList();
                return CategorySection(
                  category: category.name,
                  items: categoryProducts,
                  addToCart: (product) => cartController.addToCart(product),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0), // Adjust the padding as needed
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors
              .black, // Ensure selected item color is the same as unselected
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Payment',
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String category;
  final List<Product> items;
  final Function(Product) addToCart;

  CategorySection(
      {required this.category, required this.items, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            category,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003049)),
          ),
        ),
        Container(
          height: 300, // Increased height for the container
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemCard(
                item: items[index],
                addToCart: addToCart,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final Product item;
  final Function(Product) addToCart;

  ItemCard({required this.item, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFEFEFEF),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 200, // Increased width
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100, // Increased height for the image
              child: Center(
                child: Image.network(
                  item.images.isNotEmpty
                      ? item.images[0]
                      : 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons
                        .error); // Display an error icon if the image fails to load
                  },
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              item.name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold), // Decreased font size
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              item.description,
              style: TextStyle(
                  fontSize: 12, color: Colors.black54), // Decreased font size
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(height: 4),
            Text(
              'Quantity: ${item.quantity}',
              style: TextStyle(
                  fontSize: 12, color: Colors.black54), // Decreased font size
            ),
            SizedBox(height: 4),
            Text(
              '\$${item.unitPrice.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 14, color: Colors.green), // Decreased font size
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                addToCart(item); // Call the addToCart function
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003049),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
