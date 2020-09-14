import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

import './meal.dart';

class Meals with ChangeNotifier {
  List<Meal> _items = [];

  List<Meal> get items {
    return [..._items];
  }

  Meal findById(String id) {
    return _items.firstWhere((meal) => meal.id == id);
  }

  Future<void> fetchAndSetMeals(String category) async {
    final url =
        "https://yourcookbook-b21f2.firebaseio.com/categories/$category/meals.json";
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Meal> loadedMeals = [];
      extractedData.forEach((mealId, mealData) {
        loadedMeals.add(
          Meal(
            id: mealId,
            title: mealData["title"],
            ingredients: [...mealData["ingredients"]],
            steps: [...mealData["steps"]],
            image: mealData["image"],
            // persons: mealData["persons"],
            // duration: mealData["duration"],
          ),
        );
      });
      _items = loadedMeals;
      notifyListeners();
    } catch (error) {
      _items = [
        Meal(id: "", title: "", ingredients: [], steps: [], image: null) // , persons: 0, duration: 0)
      ];
      notifyListeners();
    }
  }

  Future<void> addMeal(String category, Meal meal) async {
    final url =
        "https://yourcookbook-b21f2.firebaseio.com/categories/$category/meals.json";
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "title": meal.title,
            "ingredients": meal.ingredients,
            "steps": meal.steps,
            "image": meal.image,
            // "persons": meal.persons,
            // "duration": meal.duration,
          },
        ),
      );

      final newMeal = Meal(
        id: json.decode(response.body)["name"],
        title: meal.title,
        ingredients: meal.ingredients,
        steps: meal.steps,
        image: meal.image,
        // persons: meal.persons,
        // duration: meal.duration,
      );
      _items.add(newMeal);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateMeal(String category, String id, Meal meal) async {
    final mealIndex = _items.indexWhere((meal) => meal.id == id);
    if (mealIndex >= 0) {
      final url =
          "https://yourcookbook-b21f2.firebaseio.com/categories/$category/meals/$id.json";

      await http.patch(
        url,
        body: json.encode(
          {
            "title": meal.title,
            "ingredients": meal.ingredients,
            "steps": meal.steps,
            "image": meal.image,
            // "persons": meal.persons,
            // "duration": meal.duration,
          },
        ),
      );

      _items[mealIndex] = meal;
      notifyListeners();
    } else {
      print("...");
    }
  }
}
