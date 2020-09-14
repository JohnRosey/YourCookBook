// import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

import '../providers/meal.dart';

class Categories with ChangeNotifier {
  final String id;
  final String title;
  final List<Meal> meals;

  Categories({
    @required this.id,
    @required this.title,
    @required this.meals,
  });


}