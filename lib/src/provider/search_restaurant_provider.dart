import 'package:flutter/material.dart';
import 'package:restaurant_app_api/src/models/restaurant_list_model.dart';
import 'package:restaurant_app_api/src/services/restaurant_services.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class SearchRestaurantProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;

  SearchRestaurantProvider({required this.restaurantServices});

  late RestaurantListModel _restaurantResult;
  late ResultState _state;

  String _message = '';
  String get message => _message;
  RestaurantListModel get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String value) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantLists = await restaurantServices.searchRestaurant(value);
      if (restaurantLists!.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        print(restaurantLists);
        return _restaurantResult = restaurantLists;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
