import 'package:frontend/shared/models/user.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState {
  const AppState._({
    required this.status,
    this.user = User.empty
  });

  final AppStatus status;
  final User user;

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated()
      : this._(status: AppStatus.unauthenticated);
}
