import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:frontend/app/bloc/bloc.dart';
import 'package:frontend/chat/bloc/bloc.dart';
import 'package:frontend/chat/view/chat.dart';
import 'package:frontend/shared/repository/authentication/authentication_repository.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ChatPage());

  @override
  Widget build(BuildContext context) {
    final authenticationRepository = context.read<AuthenticationRepository>();
    final tokenFuture = authenticationRepository.jwtToken;

    return FutureBuilder(
      future: tokenFuture,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          Socket socket = io(
            'http://localhost:3000',
            OptionBuilder()
                .setTransports(['websocket'])
                .disableAutoConnect()
                .setExtraHeaders({'Authorization': 'Bearer ${snapshot.data}'})
                .build(),
          );
          socket.connect();

          return BlocProvider(
            create: (_) => ChatBloc(socket: socket),
            child: Chat(socket: socket),
          );
        }

        if (snapshot.hasError) {
          context.read<AppBloc>().add(AppLogoutRequested());
        }

        return Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
        );
      },
    );

    // return BlocProvider(
    //   create: (_) => ChatBloc(),
    //   child: Chat(socket: socket),
    // );
  }
}
