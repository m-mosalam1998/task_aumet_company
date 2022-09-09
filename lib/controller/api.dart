import 'dart:convert';

import 'package:dio/dio.dart';

class ApiUnversity {
  Future<String?> getUniversity({required String country}) async {
    try {
      var response = await Dio()
          .get('http://universities.hipolabs.com/search?country=$country');

      return response.data.toString();
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<String?> fetchdata({required String country}) async {
    String? data = await getUniversity(country: country);
    if (data != null) {
      print(json.decode(data));
      return data;
    }
    return null;
  }
}
