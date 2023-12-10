import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/src/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_api/src/widgets/restaurant_card.dart';

class SearchRestaurantScreen extends StatefulWidget {
  const SearchRestaurantScreen({super.key});

  @override
  State<SearchRestaurantScreen> createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  final TextEditingController _textController = TextEditingController();
  @override
  void dispose() {
    _textController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: TextField(
                controller: _textController,
                onChanged: (value) {
                  Provider.of<SearchRestaurantProvider>(context, listen: false)
                      .changeSearchValue(value);

                  print(value);
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search restaurant',
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.deepPurple),
              ),
            ),
            SizedBox(
              child: Consumer<SearchRestaurantProvider>(
                builder: (context, state, child) {
                  if (state.state == ResultState.hasData) {
                    print(state.result);
                  }
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
