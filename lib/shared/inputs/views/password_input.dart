import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/shared/bloc/form/bloc_base.dart';

class PasswordInput<FormBloc extends Bloc<FormEventBase, State>, State extends FormStateBase> extends StatelessWidget {
  PasswordInput({Key? key, required FormEventBase Function(String) onChange })
      : _onChange = onChange, super(key: key);

  final FormEventBase Function(String) _onChange;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, State>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText:
              'Password should be at least 8 characters with at least one letter and number',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? 'Password must be at least 8 characters and contain at least one letter and number'
                : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.read<FormBloc>().add(_onChange(value));
          },
        );
      },
    );
  }
}
