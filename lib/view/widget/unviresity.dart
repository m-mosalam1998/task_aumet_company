import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_company/controller/dataBase/auth.dart';
import 'package:task_company/controller/providers.dart';
import 'package:task_company/global/colors.dart';
import 'package:task_company/global/values.dart';
import 'package:task_company/model/university.dart';

import '../../controller/dataBase/store_data.dart';

class CardUnversity extends ConsumerWidget {
  const CardUnversity(
      {Key? key, required this.university, required this.changSave})
      : super(key: key);
  final University university;
  final ValueChanged changSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listSave = ref.watch(userAccount);
    bool isSaved = listSave!.unversitys!.any((element) =>
        element.name == university.name &&
        element.country == university.country &&
        element.alphaTwoCode == university.alphaTwoCode);
    return Card(
      color: AppColors.bodyCardColor,
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: AppColors.borderCardColor,
        ),
      ),
      child: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    university.name,
                    style: TextStyle(
                      color: AppColors.textAndIconColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: GlobalValues.fontFamily,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (isSaved) {
                          listSave.unversitys!.removeWhere((element) =>
                              element.name == university.name &&
                              element.country == university.country &&
                              element.alphaTwoCode == university.alphaTwoCode);
                          await StoreAndLoadDataFirebase().update(
                              context: context,
                              collection: 'Users',
                              doc: FirebaseAuthuntication().uidUser(),
                              dataMap: {
                                'unversitys': jsonEncode(listSave.unversitys)
                              });
                          isSaved = false;
                          changSave(true);
                        } else {
                          listSave.unversitys!.add(university);
                          await StoreAndLoadDataFirebase().update(
                              context: context,
                              collection: 'Users',
                              doc: FirebaseAuthuntication().uidUser(),
                              dataMap: {
                                'unversitys': jsonEncode(listSave.unversitys)
                              });
                          isSaved = true;
                          changSave(true);
                        }
                      },
                      icon: Icon(
                        isSaved ? Icons.remove_circle : Icons.save,
                        color: AppColors.textAndIconColor,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Country : "),
                  Text(university.country),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
