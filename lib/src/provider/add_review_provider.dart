import 'package:flutter/material.dart';
import 'package:restaurant_app_api/src/models/add_review.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_api/src/services/restaurant_services.dart';

class AddReviewProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;
  AddReviewProvider({
    required this.restaurantServices,
  });

  bool loading = false;
  bool isBack = false;
  Future<void> postData(AddReviewModel body) async {
    loading = true;
    notifyListeners();
    http.Response response = (await restaurantServices.postreview(body))!;
    if (response.statusCode == 200) {
      isBack = true;
    }
    loading = false;
    notifyListeners();
  }
}
