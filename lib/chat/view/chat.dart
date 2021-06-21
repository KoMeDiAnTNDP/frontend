import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'messages_view.dart';
import 'send_message_view.dart';
import 'package:frontend/chat/bloc/bloc.dart';
import 'package:frontend/chat/view/app_bar.dart';

class Chat extends StatelessWidget {
  const Chat({
    Key? key,
    required Socket socket,
  }) : _socket = socket, super(key: key);

  final Socket _socket;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: ChatAppBar(socket: _socket),
        body: SafeArea(
          minimum: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MessagesView(socket: _socket),
              SendMessage(),
            ],
          ),
        )
      ),
    );
  }
}
