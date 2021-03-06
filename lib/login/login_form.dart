import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/login/bloc/bloc.dart';
import 'package:frontend/login/view/form.dart' as login_form;

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  SnackBar _createSnackBar() {
    return SnackBar(
      backgroundColor: Colors.red,
      content: const Text('The specified email or password is incorrect'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          final snackBar = _createSnackBar();

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: login_form.Form(),
    );
  }
}
