import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/shared/bloc/form/bloc_base.dart';

class EmailInput<FormBloc extends Bloc<FormEventBase, State>, State extends FormStateBase> extends StatelessWidget {
  const EmailInput({Key? key, required FormEventBase Function(String) onChange})
      : _onChange = onChange, super(key: key);

  final FormEventBase Function(String) _onChange;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, State>(
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
            context.read<FormBloc>().add(_onChange(value));
          },
        );
      }
    );
  }
  
}