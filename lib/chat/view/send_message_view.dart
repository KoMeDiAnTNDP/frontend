import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/chat/bloc/bloc.dart';
import 'package:frontend/app/bloc/app_bloc.dart';
import 'package:frontend/shared/models/models.dart';

class SendMessage extends StatelessWidget {
  SendMessage({Key? key}) : super(key: key);

  final sendController = TextEditingController();

  Message _createMessage(String message, User user) =>
      Message(
        userId: user.id,
        email: user.email!,
        message: message,
        dateTime: DateTime.now(),
      );

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    hintText: 'Enter your message here...'
                  ),
                  controller: sendController,
                  textInputAction: TextInputAction.done,
                  onChanged: (String? message) => context.read<ChatBloc>().add(ChatMessageChangedEvent(message)),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: state.message.isEmpty
                    ? null
                    : () {
                  context.read<ChatBloc>().add(ChatSendMessageEvent(_createMessage(state.message, user)));
                  sendController.clear();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
