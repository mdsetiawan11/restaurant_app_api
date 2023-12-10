import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app_api/src/common/constant.dart';
import 'package:restaurant_app_api/src/models/restaurant_detail_model.dart';
import 'package:restaurant_app_api/src/models/restaurant_list_model.dart';

class RestaurantServices {
  Future<RestaurantListModel?> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse('${apiUrl}list'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return RestaurantListModel.fromJson(data);
      } else {
        print("error");
      }
    } on SocketException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<RestaurantDetailModel?> getRestaurantDetail(id) async {
    try {
      final response = await http.get(Uri.parse('${apiUrl}detail/' + id));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        return RestaurantDetailModel.fromJson(data);
      } else {
        print("error");
      }
    } on SocketException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
