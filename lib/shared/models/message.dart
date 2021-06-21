class Message {
  const Message({
    required this.userId,
    required this.email,
    required this.message,
    required this.dateTime,
    this.userConnected = false,
  });

  final String userId;
  final String email;
  final String message;
  final DateTime dateTime;
  final bool userConnected;

  factory Message.fromJson(Map<String, dynamic> json) {
    final dateTime = DateTime.parse(json['date_time']);

    return Message(
      userId: json['user_id'],
      email: json['email'],
      message: json['message'],
      dateTime: dateTime,
      userConnected: false,
    );
  }

  bool isEmpty() => this.message.isEmpty;

  Map<String, dynamic> toJson() {
    return {
      'user_id': this.userId,
      'email': this.email,
      'message': this.message,
      'date_time': this.dateTime.toString(),
    };
  }

  Message copyWith({
    String? userId,
    String? email,
    String? message,
    DateTime? dateTime,
    bool? userConnected,
  }) {
    return Message(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      message: message ?? this.message,
      dateTime: dateTime ?? this.dateTime,
      userConnected: userConnected ?? this.userConnected,
    );
  }
}