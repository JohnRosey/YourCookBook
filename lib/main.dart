import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/recipe_steps_screen.dart';
import './screens/category_recipe_overview_screen.dart';
import './screens/categories_overview_screen.dart';
import './screens/recipe_detail_screen.dart';
import './screens/new_recipe_screen.dart';
import './providers/meals.dart';
import './screens/ingredients_screen copy.dart';
import './providers/ingredient_cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Meals(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => IngredientCart(),
        ),
      ],
      child: MaterialApp(
        title: 'Rezepte App',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(41, 45, 50, 1),
          primaryColorDark: Color.fromRGBO(106, 79, 77, 1),
          primaryColorLight: Color.fromRGBO(247, 226, 172, 1),
          accentColor: Color.fromRGBO(156, 97, 81, 1),
          backgroundColor: Color.fromRGBO(236, 153, 103, 1),
          hintColor: Color.fromRGBO(255, 254, 254, 1),
          fontFamily: "IndieFlower",
        ),
        home: CategoriesOverviewScreen(),
        routes: {
          CategoryRecipeOverviewScreen.routeName: (ctx) =>
              CategoryRecipeOverviewScreen(),
          RecipeDetailScreen.routeName: (ctx) => RecipeDetailScreen(),
          NewRecipeScreen.routeName: (ctx) => NewRecipeScreen(),
          NewRecipeScreen.routeName: (ctx) => NewRecipeScreen(),
          RecipeStepsScreen.routeName: (ctx) => RecipeStepsScreen(),
          IngredientsScreen.routeName: (ctx) => IngredientsScreen(),
          CategoriesOverviewScreen.routeName: (ctx) =>
              CategoriesOverviewScreen(),
        },
      ),
    );
  }
}
