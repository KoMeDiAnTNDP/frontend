import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import 'package:frontend/shared/inputs/models/models.dart';
import 'package:frontend/login/bloc/login_event.dart';
import 'package:frontend/login/bloc/login_state.dart';
import 'package:frontend/shared/repository/authentication/authentication_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        email: email,
        password: password,
        status: Formz.validate([email, password]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);

        try {
          await _authenticationRepository.login(
              email: state.email.value,
              password: state.password.value
          );

          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } on Exception {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      }
    }
  }

  LoginState _mapEmailChangedToState(LoginEmailChanged event, LoginState state) {
    final email = Email.dirty(event.email.value);

    return state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    );
  }

  LoginState _mapPasswordChangedToState(LoginPasswordChanged event, LoginState state) {
    final password = Password.dirty(event.password.value);

    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    );
  }
}
