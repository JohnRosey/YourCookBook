import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../providers/meal.dart';

class IngredientCartItem {
  final String id;
  final String ingredient;
  final BuildContext context;
  final List modalArgs;

  IngredientCartItem({
    @required this.id,
    @required this.ingredient,
    @required this.context,
    @required this.modalArgs,
  });
}

class IngredientCart with ChangeNotifier {
  Map<String, IngredientCartItem> _items = {};

  Map<String, IngredientCartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(
    String ingredientId,
    String ingredient,
    BuildContext context,
    List modalArgs,
    // String quantity,
  ) {
    if (_items.containsKey(ingredientId)) {
      _items.update(
        ingredientId,
        (existingIngredientCartItem) => IngredientCartItem(
          id: existingIngredientCartItem.id,
          ingredient: existingIngredientCartItem.ingredient,
          context: context,
          modalArgs: modalArgs,
        ),
      );
    } else {
      _items.putIfAbsent(
        ingredientId,
        () => IngredientCartItem(
          id: ingredientId,
          ingredient: ingredient,
          context: context,
          modalArgs: modalArgs,
        ),
      );
    }
    notifyListeners();
  }

  void removeIngredientItem(String ingredientId) {
    _items.remove(ingredientId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
