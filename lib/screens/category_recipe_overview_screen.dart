import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/categories_overview_screen.dart';
import '../screens/new_recipe_screen.dart';
import '../providers/meals.dart';
import '../widgets/meal_item.dart';

class CategoryRecipeOverviewScreen extends StatelessWidget {
  static const routeName = "category-recipe-overview";

  String category = "";

  Future<void> _refreshMeals(BuildContext context) async {
    category = ModalRoute.of(context).settings.arguments as String;
    await Provider.of<Meals>(context, listen: false).fetchAndSetMeals(category);
  }

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context).settings.arguments as String;
    // final newMeal = Meal(id: null, title: null, ingredients: null);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.category),
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
            CategoriesOverviewScreen.routeName,
            (Route<dynamic> route) => false,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          category,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 34,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            splashColor: Colors.redAccent[600],
            onPressed: () {
              Navigator.of(context).pushNamed(
                NewRecipeScreen.routeName,
                arguments: [
                  category,
                  null,
                  // newMeal,
                ],
              );
            },
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor.withOpacity(0.4),
        child: FutureBuilder(
          future: _refreshMeals(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      // backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.8),
                      onRefresh: () => _refreshMeals(context),
                      child: Consumer<Meals>(
                        builder: (ctx, mealsData, _) {
                          // print(mealsData.items[1].ingredients);
                          return ListView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: mealsData.items.length,
                            itemBuilder: (ctx, i) {
                              return ChangeNotifierProvider.value(
                                value: mealsData.items[i],
                                child: MealItem(
                                  mealsData.items[i],
                                  // id: mealsData.items[i].id,
                                  // title: mealsData.items[i].title,
                                  // imageUrl: mealsData.items[i].image,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
  }
}
