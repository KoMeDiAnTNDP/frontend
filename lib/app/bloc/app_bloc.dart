import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

import 'app_state.dart';
import 'app_event.dart';
import 'package:frontend/shared/models/user.dart';
import 'package:frontend/shared/repository/authentication/authentication_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AppState.unauthenticated()) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChange);
  }

  void _onUserChange(User user) => add(AppUserChanged(user));

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AppLogoutRequested) {
      unawaited(_authenticationRepository.logout());
    }
  }

  AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
    return event.user.isEmpty
        ? const AppState.unauthenticated()
        : AppState.authenticated(event.user);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();

    return super.close();
  }
}
