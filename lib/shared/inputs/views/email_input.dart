import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/login/bloc/bloc.dart';
import 'package:frontend/shared/inputs/models/email.dart';

class EmailInput extends StatelessWidget {
  EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. mail@gmail.com',
            errorText: state.email.invalid
              ? 'Please ensure the email entered is valid'
              : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginEmailChanged(Email.dirty(value)));
          },
        );
      }
    );
  }
  
}