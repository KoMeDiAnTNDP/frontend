import 'package:frontend/shared/models/user.dart';

abstract class AppEvent {
  const AppEvent();
}

class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);

  final User user;
}

class AppLogoutRequested extends AppEvent {}
