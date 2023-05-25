class Comment {
  final int id;
  final String content;
  final int senderId;
  final String senderName;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.content,
    required this.senderName,
    required this.senderId,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        content: json["content"],
        senderName: json['sender']['name'],
        senderId: json['sender']['id'],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
