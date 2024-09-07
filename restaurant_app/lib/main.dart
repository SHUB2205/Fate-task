import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/data_provider.dart';
import 'models/restaurant.dart';

void main() {
  runApp(ProviderScope(child: RestaurantApp()));
}

// The main widget of the app, defining the MaterialApp with the home screen
class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',  // Title of the app
      home: RestaurantListScreen(),  // Initial screen to show restaurant list
    );
  }
}

// The screen that lists all the restaurants
// This is a ConsumerWidget which listens to changes from providers using Riverpod
class RestaurantListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Reading the restaurant data from the provider
    final restaurantData = ref.watch(restaurantProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant List'),  // AppBar title
      ),
      body: restaurantData.when(
        data: (restaurants) => ListView.builder(
          // Builds a list of restaurants using ListView
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            return ListTile(
              title: Text(restaurant.name),  // Displays the name of each restaurant
              subtitle: Text(restaurant.cuisine),  // Displays the cuisine type
            );
          },
        ),
        // Display loading spinner while the data is being fetched
        loading: () => Center(child: CircularProgressIndicator()),
        // Display an error message if something goes wrong
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}