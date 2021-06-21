import 'dart:async';

import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_event.dart';
import 'signup_state.dart';
import 'package:frontend/shared/inputs/models/models.dart';
import 'package:frontend/shared/repository/authentication/authentication_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._authenticationRepository) : super(SignUpState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is SignUpPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignUpConfirmedPasswordChanged) {
      yield _mapConfirmedPasswordChangedToState(event, state);
    } else if (event is SignUpSubmitted) {
      yield* _mapSignUpSubmittedToState(event, state);
    }
  }

  SignUpState _mapEmailChangedToState(SignUpEmailChanged event, SignUpState state) {
    final email = Email.dirty(event.email.value);

    return state.copyWith(
      email: email,
      status: Formz.validate([email, state.password, state.confirmedPassword]),
    );
  }

  SignUpState _mapPasswordChangedToState(SignUpPasswordChanged event, SignUpState state) {
    final password = Password.dirty(event.password.value);

    return state.copyWith(
      password: password,
      status: Formz.validate([state.email, password, state.confirmedPassword]),
    );
  }

  SignUpState _mapConfirmedPasswordChangedToState(SignUpConfirmedPasswordChanged event, SignUpState state) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: event.confirmedPassword.value,
    );

    return state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([state.email, state.password, confirmedPassword]),
    );
  }

  Stream<SignUpState> _mapSignUpSubmittedToState(SignUpSubmitted event, SignUpState state) async* {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmedPassword = ConfirmedPassword.dirty(
        password: state.password.value,
        value: state.confirmedPassword.value
    );

    yield state.copyWith(
      email: email,
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([email, password, confirmedPassword]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        await _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
        );

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
