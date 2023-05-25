class Post {
  final int id;
  final String title;
  final String content;
  int likes;
  int comments;
  final DateTime createdAt;
  final int senderId;
  final String senderName;
  final String facultyName;
  bool isliked;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.senderName,
    required this.senderId,
    required this.facultyName,
    required this.isliked,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        likes: json["likes"],
        comments: json["comments"],
        createdAt: DateTime.parse(json["created-at"]),
        senderName: json['sender']['name'],
        senderId: json['sender']['id'],
        facultyName: json['faculty']['name'],
        isliked: json["isliked"] ?? false,
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "title": title,
  //       "content": content,
  //       "likes": likes,
  //       "comments": comments,
  //       "created-at": createdAt.toIso8601String(),
  //       "sender": sender.toJson(),
  //       "faculty": faculty.toJson(),
  //       "isliked": isliked,
  //     };
}
