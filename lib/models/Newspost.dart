class NewsPost {
  final String? name;
  final String? description;
  final String? imageUrl;

  NewsPost({this.name, this.description, this.imageUrl});

  factory NewsPost.fromJson(Map<String, dynamic> json) {
    return NewsPost(
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image'] as String?,
    );
  }
}
