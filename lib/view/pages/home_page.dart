import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:task_company/controller/api.dart';
import 'package:task_company/model/university.dart';
import 'package:task_company/view/widget/button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final List<String> countries = ['Jordan', 'Egypt', 'Spain'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomButton(
              onTap: () {
                ApiUnversity().fetchdata(country: 'jordan');
              },
              text: 'tap',
            )
          ],
        ),
      ),
    );
  }
}
