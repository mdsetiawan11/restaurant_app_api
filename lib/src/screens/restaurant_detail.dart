import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app_api/src/common/constant.dart';
import 'package:restaurant_app_api/src/provider/restaurant_detail_provider.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Image.network(
                            imgUrl + state.result.restaurant.pictureId),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                state.result.restaurant.name,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_city,
                                    color: Colors.blue.shade700,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.result.restaurant.city)
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: Colors.red.shade700,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(state.result.restaurant.address)
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade700,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      state.result.restaurant.rating.toString())
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(),
                              const Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ReadMoreText(
                                state.result.restaurant.description,
                                textAlign: TextAlign.justify,
                                trimLines: 4,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                                lessStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Categories',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state
                                        .result.restaurant.categories.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(state.result.restaurant
                                            .categories[index].name),
                                      ));
                                    }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Foods',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state
                                        .result.restaurant.menus.foods.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(state.result.restaurant
                                            .menus.foods[index].name),
                                      ));
                                    }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Drinks',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state
                                        .result.restaurant.menus.drinks.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(state.result.restaurant
                                            .menus.drinks[index].name),
                                      ));
                                    }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Reviews',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 90,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.result.restaurant
                                        .customerReviews.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.result.restaurant
                                                  .customerReviews[index].name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              state
                                                  .result
                                                  .restaurant
                                                  .customerReviews[index]
                                                  .review,
                                            ),
                                            Text(
                                              state.result.restaurant
                                                  .customerReviews[index].date,
                                            )
                                          ],
                                        ),
                                      ));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 30,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: CircleAvatar(
                              backgroundColor:
                                  Colors.deepPurple.withOpacity(0.7),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                        )),
                  ],
                ),
              );
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
          },
        ),
      ),
    );
  }
}
