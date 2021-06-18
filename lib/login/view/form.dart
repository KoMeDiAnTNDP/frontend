import 'package:flutter/material.dart';

import 'login_button.dart';
import 'package:frontend/login/bloc/bloc.dart';
import 'package:frontend/shared/inputs/views/views.dart';
import 'package:frontend/shared/inputs/models/models.dart';

class Form extends StatelessWidget {
  LoginEmailChanged _onEmailChanged(String value) {
    return LoginEmailChanged(Email.dirty(value));
  }

  LoginPasswordChanged _onPasswordChanged(String value) {
    return LoginPasswordChanged(Password.dirty(value));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: EmailInput<LoginBloc, LoginState>(onChange: _onEmailChanged),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: PasswordInput<LoginBloc, LoginState>(onChange: _onPasswordChanged),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: LoginButton(),
          ),
        ],
      ),
    );
  }
}
