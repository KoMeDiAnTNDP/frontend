import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/login/bloc/bloc.dart';
import 'package:frontend/shared/inputs/models/password.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(Password.dirty(value)));
          },
        );
      },
    );
  }
}
