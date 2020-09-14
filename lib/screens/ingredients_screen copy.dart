import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezepte_app/screens/recipe_steps_screen.dart';

import '../providers/meal.dart';
// import '../screens/recipe_steps_screen.dart';
import '../widgets/ingredient_cart_item.dart';
import '../providers/ingredient_cart.dart' show IngredientCart;

class IngredientsScreen extends StatefulWidget {
  static const routeName = "add-ingredients";
  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  int counter = 0;
  final _form = GlobalKey<FormState>();
  final _ingredientController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ingredientCart = Provider.of<IngredientCart>(context);
    final List modalArgs = ModalRoute.of(context).settings.arguments;
    Meal _editedMeal = modalArgs[2];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Erstelle die Zutatenliste",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
            ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
      color: Theme.of(context).backgroundColor.withOpacity(0.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredientCart.items.length,
                itemBuilder: (ctx, i) {
                  return IngredientCartItem(
                    id: ingredientCart.items.values.toList()[i].id,
                    ingredient:
                        ingredientCart.items.values.toList()[i].ingredient,
                    context: context,
                    // modalArgs: modalArgs,
                  );
                },
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(55),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: TextField(
                          style: TextStyle(fontSize: 20),
                          controller: _ingredientController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Gebe eine Zutat ein...',
                              contentPadding: EdgeInsets.only(left: 5),
                              hintStyle:
                                  TextStyle(color: Colors.grey[600], fontSize: 18)),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (value) {
                            value.isEmpty
                                ? null
                                : ingredientCart.addItem(
                                    counter.toString(),
                                    _ingredientController.text,
                                    context,
                                    modalArgs,
                                  );
                            value.isEmpty ? null : counter++;
                            _ingredientController.text = "";
                          },
                        ),
                      ),
                      SizedBox(width: 2),
                      IconButton(
                        icon: Icon(Icons.add),
                        splashColor: Colors.redAccent[600],
                        onPressed: () {
                          _ingredientController.text.isEmpty
                              ? null
                              : ingredientCart.addItem(
                                  counter.toString(),
                                  _ingredientController.text,
                                  context,
                                  modalArgs,
                                );
                          _ingredientController.text.isEmpty ? null : counter++;
                          _ingredientController.text = "";
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                  icon: Icon(
                    Icons.play_arrow,
                    size: 40,
                  ),
                  splashColor: Colors.redAccent[600],
                  onPressed: () {
                    List ings = ingredientCart.items.values
                        .map((ing) => ing.ingredient)
                        .toList();

                    if (ings.length == 0) {
                      return;
                    } else {
                      _editedMeal = Meal(
                        id: _editedMeal.id,
                        title: _editedMeal.title,
                        ingredients: ings,
                        steps: _editedMeal.steps,
                        image: _editedMeal.image,
                      );
                      Navigator.of(context).pushNamed(
                        RecipeStepsScreen.routeName,
                        arguments: [
                          modalArgs[0],
                          modalArgs[1],
                          _editedMeal,
                        ],
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
