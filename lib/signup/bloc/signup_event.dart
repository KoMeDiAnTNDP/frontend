import 'package:frontend/shared/inputs/models/models.dart';
import 'package:frontend/shared/bloc/form/form_event_base.dart';

abstract class SignUpEvent extends FormEventBase {
  const SignUpEvent();
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);

  final Email email;
}

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);

  final Password password;
}

class SignUpConfirmedPasswordChanged extends SignUpEvent {
  const SignUpConfirmedPasswordChanged(this.confirmedPassword);

  final ConfirmedPassword confirmedPassword;
}

class SignUpSubmitted extends SignUpEvent {}
