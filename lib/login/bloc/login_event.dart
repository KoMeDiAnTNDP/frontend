import 'package:frontend/shared/inputs/models/models.dart';

abstract class LoginEvent {
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
