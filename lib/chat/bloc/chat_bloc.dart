import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'chat_event.dart';
import 'chat_state.dart';
import 'package:frontend/shared/models/models.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required Socket socket}) : _socket = socket, super(const ChatState());

  final Socket _socket;

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatUserConnectedEvent) {
      yield _mapUserConnectedEventToState(event, state);
    } else if (event is ChatUserDisconnectedEvent) {
      yield _mapUserDisconnectedEventToMap(event, state);
    } else if (event is ChatMessageChangedEvent) {
      yield state.copyWith(message: event.message);
    } else if (event is ChatSendMessageEvent) {
      yield _mapSendMessageEventToState(event, state);
    } else if (event is ChatReceivedMessageEvent) {
      yield _mapReceivedMessageEventToState(event, state);
    }
  }

  ChatState _mapUserConnectedEventToState(ChatUserConnectedEvent event, ChatState state) {
    final copyUsers = state.users.map((user) => user.copyWith()).toList();
    copyUsers.add(event.user);

    final newMessage = Message(
      userId: event.user.id,
      email: event.user.email!,
      message: 'User ${event.user.email} has connected',
      dateTime: event.user.connectionTime!,
      userConnected: true,
    );
    final copyMessages = state.messages
        .map((message) => message.copyWith())
        .toList();

    copyMessages.add(newMessage);

    copyMessages.sort((prev, next) => prev.dateTime.compareTo(next.dateTime));

    return state.copyWith(users: copyUsers, messages: copyMessages);
  }

  ChatState _mapUserDisconnectedEventToMap(ChatUserDisconnectedEvent event, ChatState state) {
    final copyUsers = state.users.map((user) => user.copyWith()).toList();

    copyUsers.removeWhere((user) => user.id == event.user.id);

    final newMessage = Message(
      userId: event.user.id,
      email: event.user.email!,
      message: 'User ${event.user.email} has disconnected',
      dateTime: event.user.connectionTime!,
      userConnected: true,
    );
    final copyMessages = state.messages
        .map((message) => message.copyWith())
        .toList();

    copyMessages.add(newMessage);

    copyMessages.sort((prev, next) => prev.dateTime.compareTo(next.dateTime));

    return state.copyWith(users: copyUsers, messages: copyMessages);
  }

  ChatState _mapSendMessageEventToState(ChatSendMessageEvent event, ChatState state) {
    _socket.emit('send_message', event.message.toJson());

    final copyMessages = state.messages
        .map((message) => message.copyWith())
        .toList();
    copyMessages.add(event.message);
    copyMessages.sort((prev, next) => prev.dateTime.compareTo(next.dateTime));

    return state.copyWith(messages: copyMessages, message: '');
  }

  ChatState _mapReceivedMessageEventToState(ChatReceivedMessageEvent event, ChatState state) {
    final copyMessages = state.messages
        .map((message) => message.copyWith())
        .toList();
    copyMessages.add(event.message);
    copyMessages.sort((prev, next) => prev.dateTime.compareTo(next.dateTime));

    return state.copyWith(messages: copyMessages);
  }
}
