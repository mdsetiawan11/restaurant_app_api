import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/src/provider/restaurant_provider.dart';
import 'package:restaurant_app_api/src/widgets/restaurant_card.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          Icon(
            Icons.search,
            size: 30,
            color: Colors.deepPurple,
          ),
          SizedBox(
            width: 15,
          )
        ],
        title: const Row(
          children: [
            Text('Restaurant'),
            SizedBox(
              width: 5,
            ),
            Text(
              'App',
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          child: Consumer<RestaurantProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                  itemCount: state.result.restaurants.length,
                  itemBuilder: ((context, index) {
                    var restaurant = state.result.restaurants[index];
                    return GestureDetector(
                        onTap: () {
                          context.pushNamed('detail', pathParameters: {
                            "id": restaurant.id,
                          });
                        },
                        child: RestaurantCard(restaurant: restaurant));
                  }));
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
