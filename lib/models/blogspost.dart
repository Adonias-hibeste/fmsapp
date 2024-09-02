class BlogPost {
  final String? name;
  final String? description;
  final String? imageUrl;

  BlogPost({this.name, this.description, this.imageUrl});

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image'] as String?,
    );
  }
}
