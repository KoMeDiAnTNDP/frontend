import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/signup/bloc/bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const CircularProgressIndicator();
        }

        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => context.read<SignUpBloc>().add(SignUpSubmitted())
              : null,
          child: const Text('Sign Up'),
        );
      },
    );
  }
}
