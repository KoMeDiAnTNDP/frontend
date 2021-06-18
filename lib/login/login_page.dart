import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';
import 'package:frontend/login/bloc/bloc.dart';
import 'package:frontend/signup/bloc/bloc.dart';
import 'package:frontend/signup/signup_form.dart';
import 'package:frontend/shared/repository/authentication/authentication_repository.dart';

const String signInKey = 'sign_in';
const String signUpKey = 'sign_up';
const List<Tab> tabs = <Tab>[
  Tab(key: Key(signInKey), text: 'Sign In'),
  Tab(key: Key(signUpKey), text: 'Sign Up')
];

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  Widget _createLoginFrom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_) => LoginBloc(context.read<AuthenticationRepository>()),
        child: LoginForm(),
      ),
    );
  }

  Widget _createSignUpForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: BlocProvider(
        create: (_) => SignUpBloc(context.read<AuthenticationRepository>()),
        child: SignUpForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (BuildContext context) {
          final tabController = DefaultTabController.of(context)!;
          
          tabController.addListener(() {
            if (tabController.indexIsChanging) {
              ScaffoldMessenger.of(context).clearSnackBars();
            }
          });

          return Scaffold(
            appBar: AppBar(
              title: const Text('Authorization'),
              bottom: const TabBar(tabs: tabs),
            ),
            body: TabBarView(
              children: tabs.map((Tab tab) {
                final key = tab.key.toString();

                if (key.contains(signInKey)) {
                  return _createLoginFrom(context);
                }

                if (key.contains(signUpKey)) {
                  return _createSignUpForm(context);
                }

                return Center(
                  child: Text(
                    'Tab',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                );
              }).toList(),
            ),
          );
        },
      )
    );
  }
}
