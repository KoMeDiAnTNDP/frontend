import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/login/bloc/bloc.dart';

class LoginButton extends StatelessWidget {
  LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const CircularProgressIndicator();
        }

        return ElevatedButton(
          onPressed: state.status.isValidated
            ? () => context.read<LoginBloc>().add(LoginSubmitted())
            : null,
          child: const Text('Login'),
        );
      },
    );
  }
}
