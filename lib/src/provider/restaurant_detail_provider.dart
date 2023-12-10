import 'package:flutter/material.dart';
import 'package:restaurant_app_api/src/models/restaurant_detail_model.dart';
import 'package:restaurant_app_api/src/services/restaurant_services.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;
  String id;

  RestaurantDetailProvider(
      {required this.restaurantServices, required this.id}) {
    _fetchRestaurantDetail();
  }

  late RestaurantDetailModel _restaurantDetailResult;
  late ResultState _state;

  String _message = '';

  String get message => _message;

  RestaurantDetailModel get result => _restaurantDetailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await restaurantServices.getRestaurantDetail(id);
      if (restaurantDetail!.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
