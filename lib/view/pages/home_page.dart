import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_company/controller/providers.dart';
import 'package:task_company/global/colors.dart';
import 'package:task_company/global/values.dart';
import 'package:task_company/view/components/pagination.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final List<String> countries = ['Jordan', 'Egypt', 'Spain'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Consumer(builder: (_, ref, child) {
                  final countrySelected = ref.watch(selectedUnversity);
                  return DropdownButton(
                      items: countries
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textAndIconColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GlobalValues.fontFamily,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: countrySelected,
                      onChanged: (String? item) {
                        ref.read(selectedUnversity.notifier).state = item!;
                        // ref.read(universitys.);
                      });
                }),
                Expanded(child: PaginationUnversity()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
