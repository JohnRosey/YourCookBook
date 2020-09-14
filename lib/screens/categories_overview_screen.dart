import 'package:flutter/material.dart';

import "./category_recipe_overview_screen.dart";

class CategoriesOverviewScreen extends StatelessWidget {
  static const routeName = "categories-overview";
  void selectCategory(BuildContext ctx, String id, String category) {
    Navigator.of(ctx).pushNamed(
      CategoryRecipeOverviewScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "YourCookBook",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 38,
          ),
        ),
      ),
      // drawer: AppDrawer(),
      body: Container(
        color: Theme.of(context).backgroundColor.withOpacity(0.4),
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Theme.of(context).backgroundColor.withOpacity(0.9),
              elevation: 4,
              onPressed: () => selectCategory(
                context,
                "c1",
                "Frühstück",
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Frühstück",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Theme.of(context).backgroundColor.withOpacity(0.9),
              elevation: 4,
              onPressed: () => selectCategory(
                context,
                "c2",
                "Mittagsgerichte",
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Mittagsgerichte",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Theme.of(context).backgroundColor.withOpacity(0.9),
              elevation: 4,
              onPressed: () => selectCategory(
                context,
                "c3",
                "Nachtische",
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Nachtische",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Theme.of(context).backgroundColor.withOpacity(0.9),
              elevation: 4,
              onPressed: () => selectCategory(
                context,
                "c4",
                "Getränke",
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Getränke",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
