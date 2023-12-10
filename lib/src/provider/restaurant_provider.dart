import 'package:flutter/material.dart';
import 'package:restaurant_app_api/src/models/restaurant_list_model.dart';
import 'package:restaurant_app_api/src/services/restaurant_services.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class RestaurantProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;

  RestaurantProvider({required this.restaurantServices}) {
    _fetchAllRestaurant();
  }

  late RestaurantListModel _restaurantResult;
  late ResultState _state;

  String _message = '';
  String get message => _message;
  RestaurantListModel get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await restaurantServices.getRestaurantList();
      if (restaurantList!.restaurants.isEmpty) {
        _state = ResultState.noData;
        print(restaurantList);
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantList;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
