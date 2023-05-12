import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/countrymodel.dart';
import '../../model/covidmodel.dart';

class covidservices {
  Future<Covidmodel> fetchwordstatsapi() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Covidmodel.fromJson(data);
    } else {
      return Covidmodel.fromJson(data);
    }
  }

  Future<List<dynamic>> fetchcountrylistapi() async {
    var data;
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('error');
    }
  }
}
