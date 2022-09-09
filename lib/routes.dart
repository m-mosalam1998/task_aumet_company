import 'package:flutter/material.dart';
import 'package:task_company/view/pages/home_page.dart';

import 'view/pages/check_email_validation.dart';
import 'view/pages/login_page.dart';

class Routs {
  Map<String, Widget Function(BuildContext)> routs = {
    '/Login': (context) => const LoginPage(),
    '/email': (context) => const EmailActivation(),
    '/home': (context) => HomePage(),
  };
}
