class Comment {
  final int id;
  final String comment;
  final int userId;

  Comment({required this.id, required this.comment, required this.userId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      comment: json['comment'],
      userId: json['user_id'],
    );
  }
}
