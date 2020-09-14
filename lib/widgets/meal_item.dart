import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meal.dart';
import '../screens/recipe_detail_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MealItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  final Meal meal;
  final int duration = 10;

  MealItem(
    @required this.meal,
    // @required this.id,
    // @required this.title,
    // @required this.imageUrl,
  );

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      RecipeDetailScreen.routeName,
      arguments: meal,
    );
    //     .then((result) {
    //   if (result != null) {
    //     // removeItem(result);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final meal = Provider.of<Meal>(context, listen: false);

    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.image,
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Container(
              // color: Theme.of(context).backgroundColor.withOpacity(0.8),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Flexible(
                  //   flex: 7,
                    // child: 
                    Text(
                      meal.title,
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  // ),
                  // Flexible(
                    // flex: 2,
                    // child: 
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.schedule,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "$duration min",
                          style: TextStyle(
                            fontSize: 19,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
