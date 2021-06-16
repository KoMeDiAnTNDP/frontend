import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/login/bloc/bloc.dart';

import 'package:frontend/login/login_form.dart';
import 'package:frontend/shared/repository/authentication/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => LoginBloc(context.read<AuthenticationRepository>()),
          child: LoginForm(),
        ),
      )
    );
  }
}
