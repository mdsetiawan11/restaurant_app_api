import 'package:flutter/material.dart';
import 'package:restaurant_app_api/src/services/restaurant_services.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;

  SearchRestaurantProvider({required this.restaurantServices});
}
