import 'package:membermanagementsystem/constants/constants.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final int? categoryId;
  final int quantity;
  final double unitPrice;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    this.categoryId,
    required this.quantity,
    required this.unitPrice,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<String> imageUrls =
        List<String>.from(json['images'].map((x) => url2 + x['image']));
    print('Image URLs: $imageUrls'); // Debug print
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryId:
          json['catagory_id'] != null ? json['catagory_id'] as int : null,
      quantity: json['quantity'],
      unitPrice: double.parse(json['unit_price']),
      images: imageUrls,
    );
  }
}
