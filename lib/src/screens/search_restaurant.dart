import 'package:flutter/material.dart';

class SearchRestaurantScreen extends StatefulWidget {
  const SearchRestaurantScreen({super.key});

  @override
  State<SearchRestaurantScreen> createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search restaurant',
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
