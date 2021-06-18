import 'package:frontend/shared/inputs/models/models.dart';
import 'package:frontend/shared/bloc/form/form_event_base.dart';

abstract class LoginEvent extends FormEventBase {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final Email email;
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final Password password;
}

class LoginSubmitted extends LoginEvent {}
