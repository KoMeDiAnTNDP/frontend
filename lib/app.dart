import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/app/bloc/app_bloc.dart';
import 'package:frontend/app/routes/routes.dart';
import 'package:frontend/app/bloc/app_state.dart';
import 'package:frontend/shared/repository/authentication/authentication_repository.dart';

class App extends StatelessWidget {
  App({
    Key? key,
    required AuthenticationRepository authenticationRepository
  }) : _authenticationRepository = authenticationRepository, super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authenticationRepository: _authenticationRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGeneratePages,
      ),
    );
  }
}
