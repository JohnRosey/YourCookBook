import 'package:flutter/material.dart';

import '../providers/meal.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = "/recipe";

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Text(
        text,
        style: TextStyle(fontSize: 28),
      ),
    );
  }

  Widget buildContainer(Widget child, double numitems, double heightfactor) {
    double height = numitems * 44.0 * heightfactor + 60;
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: height,
        width: double.infinity,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;

    // final loadedMeal = Provider.of<Meals>(context, listen: false).findById(mealId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.restaurant_menu),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          meal.title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 34,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).backgroundColor.withOpacity(0.4),
        child: SingleChildScrollView(
          // padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  meal.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              buildSectionTitle(context, "Zutaten"),
              Container(
                // color: Theme.of(context).backgroundColor.withOpacity(0.4),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: (meal.ingredients.length.toDouble() * 40.0 + 60),
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) => Card(
                    child: Container(
                      color: Theme.of(context).backgroundColor.withOpacity(0.7),
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      child: Text(
                        meal.ingredients[index],
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  itemCount: meal.ingredients.length,
                ),
              ),
              buildSectionTitle(context, "Anleitung"),
              buildContainer(
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "#${(index + 1)}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        title: Text(
                          meal.steps[index],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Divider(),
                    ],
                  ),
                  itemCount: meal.steps.length,
                ),
                meal.steps.length.toDouble(),
                1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
