import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/data_provider.dart';
import 'models/restaurant.dart';

void main() {
  runApp(ProviderScope(child: RestaurantApp()));
}

class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      home: RestaurantListScreen(),
    );
  }
}

class RestaurantListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantData = ref.watch(restaurantProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
      ),
      body: restaurantData.when(
        data: (restaurants) => RestaurantList(restaurants: restaurants),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class RestaurantList extends StatefulWidget {
  final List<Restaurant> restaurants;
  
  RestaurantList({required this.restaurants});

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredRestaurants = widget.restaurants
        .where((restaurant) => restaurant.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(labelText: 'Search'),
            onChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredRestaurants.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredRestaurants[index].name),
                subtitle: Text(filteredRestaurants[index].cuisine),
              );
            },
          ),
        ),
      ],
    );
  }
}
