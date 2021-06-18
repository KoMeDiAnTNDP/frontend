import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/shared/inputs/models/confirmed_password.dart';

import 'package:frontend/signup/bloc/bloc.dart';

class ConfirmedPasswordInput extends StatelessWidget {
  const ConfirmedPasswordInput({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.confirmedPassword.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock_outline),
            labelText: 'Confirmed Password',
            errorText: state.password.invalid
                ? 'Password do not match'
                : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.read<SignUpBloc>().add(
              SignUpConfirmedPasswordChanged(
                ConfirmedPassword.dirty(
                  password: state.password.value,
                  value: value,
                )
              )
            );
          },
        );
      },
    );
  }
}
