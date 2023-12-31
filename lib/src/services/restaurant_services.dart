import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app_api/src/common/constant.dart';
import 'package:restaurant_app_api/src/models/restaurant_detail_model.dart';
import 'package:restaurant_app_api/src/models/restaurant_list_model.dart';
import 'package:restaurant_app_api/src/models/restaurant_searched_model.dart';

class RestaurantServices {
  Future getRestaurantList() async {
    final response = await http.get(Uri.parse('${apiUrl}list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return RestaurantListModel.fromJson(data);
    }
  }

  Future getRestaurantDetail(id) async {
    final response = await http.get(Uri.parse('${apiUrl}detail/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return RestaurantDetailModel.fromJson(data);
    }
  }

  Future searchRestaurant(query) async {
    final response = await http.get(Uri.parse('${apiUrl}search?q=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return RestaurantSearchedModel.fromJson(data);
    }
  }
}
