import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/login/bloc/bloc.dart';

import 'package:frontend/login/view/form.dart' as login_form;
import 'package:frontend/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {

      },
      child: login_form.Form(),
    );
  }
}
