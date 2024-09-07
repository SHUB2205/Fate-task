import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant.dart'; // Adjust the import for the model

final restaurantProvider = FutureProvider<List<Restaurant>>((ref) async {
  final String response = await rootBundle.loadString('assets/restaurants.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Restaurant.fromJson(json)).toList();
});
