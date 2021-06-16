import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_button.dart';
import 'package:frontend/login/bloc/bloc.dart';
import 'package:frontend/shared/inputs/views/views.dart';

class Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: EmailInput(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: PasswordInput(),
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
