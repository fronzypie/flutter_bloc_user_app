class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final List<String> tags;
  final int reactions;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    int parseIntSafe(dynamic value) {
      if (value == null) return 0;  // Or handle as you want
      if (value is int) return value;
      if (value is String && value.isNotEmpty) {
        return int.tryParse(value) ?? 0;
      }
      return 0;
    }

    return Post(
      id: parseIntSafe(json['id']),
      userId: parseIntSafe(json['userId']),
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      tags: json['tags'] != null
          ? List<String>.from(json['tags'].map((tag) => tag.toString()))
          : [],
      reactions: parseIntSafe(json['reactions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'tags': tags,
      'reactions': reactions,
    };
  }
}
