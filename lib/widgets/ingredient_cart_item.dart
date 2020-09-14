import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meal.dart';
import '../screens/recipe_steps_screen.dart';
import "../providers/ingredient_cart.dart";

class IngredientCartItem extends StatelessWidget {
  IngredientCartItem({
    @required this.id,
    @required this.ingredient,
    @required this.context,
    // @required this.modalArgs,
  });

  final String id;
  final String ingredient;
  final BuildContext context;
  // final List modalArgs;

  @override
  Widget build(BuildContext context) {    
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).backgroundColor.withOpacity(0.2),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Bist du sicher?"),
            content: Text("Willst du die Zutat aus deiner Liste entfernen?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text("Nein"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text("Ja"),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<IngredientCart>(context, listen: false)
            .removeIngredientItem(id);
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        title: Text(
          ingredient,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
