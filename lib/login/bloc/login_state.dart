import 'package:formz/formz.dart';

import 'package:frontend/shared/inputs/models/models.dart';
import 'package:frontend/shared/bloc/form/form_state_base.dart';

class LoginState extends FormStateBase {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure
  });

  final Email email;
  final Password password;
  final FormzStatus status;

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}