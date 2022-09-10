import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_company/view/components/login_page.dart';
import 'package:task_company/view/components/registration_page.dart';

import '../../controller/providers.dart';

class Registration extends ConsumerWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerSwip = ref.watch(swiperController);
    List<Widget> pages = [LogInPage(), const RegistrationPage()];
    return Scaffold(
      body: Swiper(
        itemCount: 2,
        autoplay: false,
        controller: controllerSwip,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return pages.elementAt(index);
        },
      ),
    );
  }
}
