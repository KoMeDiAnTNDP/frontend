import 'package:formz/formz.dart';

import 'package:frontend/shared/inputs/models/models.dart';

abstract class FormStateBase {
  const FormStateBase({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword,
    this.status = FormzStatus.pure
  });

  final Email email;
  final Password password;
  final ConfirmedPassword? confirmedPassword;
  final FormzStatus status;
}