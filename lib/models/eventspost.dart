class EventsPost {
  final String? name;
  final String? description;
  final String? imageUrl;

  EventsPost({this.name, this.description, this.imageUrl});

  factory EventsPost.fromJson(Map<String, dynamic> json) {
    return EventsPost(
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image'] as String?,
    );
  }
}
