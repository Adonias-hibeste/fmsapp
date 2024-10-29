class Membership {
  final int id;
  final String name;
  final double? price; // Allow null or double type for price

  Membership({required this.id, required this.name, this.price});

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'],
      name: json['name'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
