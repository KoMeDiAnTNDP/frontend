import 'package:flutter/material.dart';

import 'signup_button.dart';
import 'confirmed_password_input.dart';
import 'package:frontend/signup/bloc/bloc.dart';
import 'package:frontend/shared/inputs/views/views.dart';
import 'package:frontend/shared/inputs/models/models.dart';

class Form extends StatelessWidget {
  SignUpEmailChanged _onEmailChanged(String value) {
    return SignUpEmailChanged(Email.dirty(value));
  }

  SignUpPasswordChanged _onPasswordChanged(String value) {
    return SignUpPasswordChanged(Password.dirty(value));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: EmailInput<SignUpBloc, SignUpState>(onChange: _onEmailChanged),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: PasswordInput<SignUpBloc, SignUpState>(onChange: _onPasswordChanged),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: ConfirmedPasswordInput(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: SignUpButton(),
          )
        ],
      ),
    );
  }
}
