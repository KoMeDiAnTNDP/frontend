import 'package:flutter/material.dart';

import 'package:frontend/home/home_page.dart';
import 'package:frontend/login/login_page.dart';
import 'package:frontend/app/bloc/app_state.dart';

List<Page> onGeneratePages(AppStatus status, List<Page<dynamic>> pages) {
  switch (status) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
