import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/src/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_api/src/widgets/restaurant_searched_card.dart';

class SearchRestaurantScreen extends StatefulWidget {
  const SearchRestaurantScreen({super.key});

  @override
  State<SearchRestaurantScreen> createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProv>(
      create: (context) => SearchRestaurantProv(),
      builder: (context, child) {
        return Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search restaurant or menu name',
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  Provider.of<SearchRestaurantProv>(context,
                                          listen: false)
                                      .searchRestaurant(_textController.text);
                                },
                                child: const Icon(Icons.search)),
                            suffixIconColor: Colors.deepPurple),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  context.watch<SearchRestaurantProv>().isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : context.watch<SearchRestaurantProv>().result.founded > 0
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView.builder(
                                  itemCount: context
                                      .watch<SearchRestaurantProv>()
                                      .result
                                      .founded,
                                  itemBuilder: (context, index) {
                                    var restaurant = context
                                        .watch<SearchRestaurantProv>()
                                        .result
                                        .restaurants[index];
                                    return GestureDetector(
                                        onTap: () {
                                          context.pushNamed('detail',
                                              pathParameters: {
                                                "id": restaurant.id,
                                              });
                                        },
                                        child: RestaurantSearchedCard(
                                            restaurant: restaurant));
                                  }),
                            )
                          : context
                                      .watch<SearchRestaurantProv>()
                                      .result
                                      .founded ==
                                  0
                              ? Center(
                                  child: Text(context
                                      .watch<SearchRestaurantProv>()
                                      .message),
                                )
                              : const SizedBox()
                ],
              ),
            ));
      },
    );
  }
}
