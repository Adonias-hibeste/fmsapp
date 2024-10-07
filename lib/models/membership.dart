class Membership {
  final int id;
  final String name;

  Membership({required this.id, required this.name});

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
