import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'package:frontend/shared/repository/authentication/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(App(authenticationRepository: authenticationRepository));
}
