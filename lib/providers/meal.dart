import 'dart:io';

import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

class Meal with ChangeNotifier {
  final String id;
  final String title;
  final List<String> ingredients;
  final List<String> steps;
  final String image;
  // final Int persons;
  // final Int duration;

  Meal({
    @required this.id,
    @required this.title,
    @required this.ingredients,
    @required this.steps,
    @required this.image,
    // @required this.persons,
    // @required this.duration,
  });
}