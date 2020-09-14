import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/categories_overview_screen.dart';
import '../providers/meal.dart';
import '../providers/meals.dart';
import '../screens/category_recipe_overview_screen.dart';
import '../providers/ingredient_cart.dart';

class RecipeStepsScreen extends StatefulWidget {
  static const routeName = "/recipe-steps";
  @override
  _RecipeStepsScreenState createState() => _RecipeStepsScreenState();
}

class _RecipeStepsScreenState extends State<RecipeStepsScreen> {
  // final _form = GlobalKey<FormState>();

  int count = 0;
  var steps = [];
  var stepControllers = <TextEditingController>[];
  var stepFields = <Widget>[];
  var _isLoading = false;
  Meal _editedMeal = Meal(
    id: null,
    title: "",
    ingredients: [],
    steps: [],
    image: null,
  );

  Widget createCard(Meal _editedMeal, List modalArgs) {
    var stepController = TextEditingController();
    stepControllers.add(stepController);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10,
      ),
      child: Material(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text(
                  "#${count + 1}",
                  style: TextStyle(
                    color: Color.fromRGBO(41, 45, 50, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Color.fromRGBO(236, 153, 103, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(41, 45, 50, 1),
                ),
                controller: stepController,
                // textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Gebe bitte einen Namen ein.";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    stepFields.add(
      createCard(
        Meal(
          id: null,
          title: "",
          ingredients: [],
          steps: [],
          image: null,
        ),
        [],
      ),
    );
    super.initState();
  }

  Future<void> _saveMeal() async {
    final ingredientCart = Provider.of<IngredientCart>(context, listen: false);

    steps = stepControllers.map((ing) => ing.text).toList();
    for (int i = 0; i < steps.length; i++) {
      if (steps[i].isEmpty) {
        return;
      }
    }
    final modalArgs = ModalRoute.of(context).settings.arguments as List;

    setState(() {
      _isLoading = true;
    });

    _editedMeal = Meal(
      id: _editedMeal.id,
      title: _editedMeal.title,
      ingredients: _editedMeal.ingredients,
      steps: steps,
      image: _editedMeal.image,
    );

    if (_editedMeal.id != null) {
      await Provider.of<Meals>(context, listen: false)
          .updateMeal(modalArgs[0], _editedMeal.id, _editedMeal);
    } else {
      try {
        await Provider.of<Meals>(context, listen: false)
            .addMeal(modalArgs[0], _editedMeal);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Es trat ein Fehler auf!"),
            content: Text("Es ist leider etwas schief gelaufen"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                      CategoryRecipeOverviewScreen.routeName);
                },
                child: Text("okay"),
              ),
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = true;
    });
    ingredientCart.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
      CategoryRecipeOverviewScreen.routeName,
      (Route<dynamic> route) => false,
      arguments: modalArgs[0],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List modalArgs = ModalRoute.of(context).settings.arguments;

    if (stepFields.length == 1) {
      _editedMeal = modalArgs[2];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Gebe die Schritte ein",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveMeal,
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor.withOpacity(0.4),
        padding: EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: stepFields.length,
                  itemBuilder: (BuildContext context, int index) {
                    return stepFields[index];
                  }),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 2, 0, 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                // color: Theme.of(context).hintColor,
                elevation: 4,
                color: Theme.of(context).hintColor,
                child: Icon(Icons.add),
                splashColor: Theme.of(context).backgroundColor,
                onPressed: () {
                  steps = stepControllers.map((ing) => ing.text).toList();
                  setState(
                    () {
                      count = count + 1;
                      stepFields.add(createCard(_editedMeal, modalArgs));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
