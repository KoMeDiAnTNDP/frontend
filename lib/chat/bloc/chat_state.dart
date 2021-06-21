import 'package:frontend/shared/models/models.dart';

class ChatState {
  const ChatState({
    this.users = const [],
    this.messages = const [],
    this.message = '',
  });

  final List<User> users;
  final List<Message> messages;
  final String message;

  ChatState copyWith({
    List<User>? users,
    List<Message>? messages,
    String? message,
  }) {
    return ChatState(
      users: users ?? this.users,
      messages: messages ?? this.messages,
      message: message ?? this.message
    );
  }
}