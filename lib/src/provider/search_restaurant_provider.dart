import 'package:flutter/material.dart';
import 'package:restaurant_app_api/src/models/restaurant_searched_model.dart';
import 'package:restaurant_app_api/src/services/restaurant_services.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class SearchRestaurantProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;
  String _value = '';

  void changeSearchValue(String value) {
    _value = value;
    searchRestaurant(_value);
    notifyListeners();
  }

  SearchRestaurantProvider({required this.restaurantServices}) {
    searchRestaurant(_value);
  }

  late RestaurantSearchedModel _restaurantResult;
  late ResultState _state;

  String _message = '';
  String get message => _message;
  RestaurantSearchedModel get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String value) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      print(value);
      final restaurantLists = await restaurantServices.searchRestaurant(value);
      if (restaurantLists!.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _restaurantResult = restaurantLists;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
