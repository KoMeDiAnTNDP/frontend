import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:frontend/app/bloc/bloc.dart';
import 'package:frontend/chat/bloc/bloc.dart';
import 'package:frontend/shared/models/user.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    Key? key,
    required Socket socket,
  }) : _socket = socket, super(key: key);

  final Socket _socket;

  @override
  Size get preferredSize => const Size.fromHeight(70);
  
  void onPressed(BuildContext context, User user) {
    _socket.emit('user_disconnected', user.toJson());
    _socket.disconnect();
    context.read<AppBloc>().add(AppLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return AppBar(
      title: const Text('Chat'),
      actions: [
        IconButton(
          onPressed: () => onPressed(context, user),
          icon: const Icon(Icons.exit_to_app),
        ),
      ],
    );
  }
}
