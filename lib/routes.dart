import 'package:flutter/material.dart';
import 'package:task_company/view/pages/home_page.dart';
import 'package:task_company/view/pages/registration.dart';

import 'view/pages/check_email_validation.dart';

class Routs {
  Map<String, Widget Function(BuildContext)> routs = {
    '/registration': (context) => const Registration(),
    '/email': (context) => const EmailActivation(),
    '/home': (context) => HomePage(),
  };
}
