import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/chat/view/user_message_box.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:frontend/chat/bloc/bloc.dart';
import 'package:frontend/app/bloc/app_bloc.dart';
import 'package:frontend/shared/models/models.dart';
import 'package:frontend/chat/view/message_box.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({
    Key? key,
    required Socket socket
  }) : _socket = socket, super(key: key);

  final Socket _socket;

  bool _isOwnMessage(Message message, User user) => user.id == message.userId;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final chatBloc = context.read<ChatBloc>();

    _socket.on('received_message', (message) {
      chatBloc.add(ChatReceivedMessageEvent(Message.fromJson(message)));
    });

    _socket.on('user_connected', (user) {
      final connectedUser = User.fromJson(user);

      chatBloc.add(ChatUserConnectedEvent(connectedUser));
    });

    _socket.on('user_disconnected', (user) {
      final disconnectedUser = User.fromJson(user);

      chatBloc.add(ChatUserDisconnectedEvent(disconnectedUser));
    });

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state.messages.isNotEmpty) {
          return Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 16),
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = state.messages[index];

                  if (message.userConnected) {
                    return UserMessageBox(text: message.message);
                  }

                  return MessageBox(
                    text: message.message,
                    isOwn: _isOwnMessage(message, user),
                    dateTime: message.dateTime,
                    email: message.email,
                  );
                },
              ),
            ),
          );
        }

        return Expanded(
          child: Container(
            child: Center(
              child: const Text('No messages in channel'),
            ),
          ),
        );
      },
    );
  }
}
