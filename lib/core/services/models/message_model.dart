class MessageModel {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime createdAt;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
