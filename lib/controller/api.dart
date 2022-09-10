import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_company/model/university.dart';

class ApiUnversity {
  Future<List?> getUniversity({required String country}) async {
    try {
      var response = await Dio()
          .get('http://universities.hipolabs.com/search?country=$country');
      return (response.data);
    } catch (e) {
      return null;
    }
  }

  Future<List<University>> fetchdata({required String country}) async {
    List<dynamic>? data = await getUniversity(country: country);
    if (data == null) {
      throw "can't fetch data please try agian";
    }
    final json1 = data.first;
    List<University> _univesity = [];
    for (var element in data) {
      _univesity.add(University.fromJson(element));
    }

    return _univesity;
  }
}
