import 'package:flutter/material.dart';

import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/signup/bloc/bloc.dart';
import 'package:frontend/signup/view/form.dart' as signup_form;

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}): super(key: key);

  SnackBar _createSnackBar() {
    return SnackBar(
      backgroundColor: Colors.red,
      content: const Text('An error occurred while creating your account'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          final snackBar = _createSnackBar();

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: signup_form.Form(),
    );
  }
}
