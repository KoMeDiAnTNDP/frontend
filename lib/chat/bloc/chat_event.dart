import 'package:frontend/shared/models/models.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class ChatUserConnectedEvent extends ChatEvent {
  const ChatUserConnectedEvent(this.user);

  final User user;
}

class ChatUserDisconnectedEvent extends ChatEvent {
  const ChatUserDisconnectedEvent(this.user);

  final User user;
}

class ChatMessageChangedEvent extends ChatEvent {
  const ChatMessageChangedEvent(this.message);

  final String? message;
}

class ChatSendMessageEvent extends ChatEvent {
  const ChatSendMessageEvent(this.message);

  final Message message;
}

class ChatReceivedMessageEvent extends ChatEvent {
  const ChatReceivedMessageEvent(this.message);

  final Message message;
}
