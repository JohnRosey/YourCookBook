import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../providers/meal.dart';
import '../providers/meals.dart';
import '../screens/ingredients_screen copy.dart';
import '../widgets/image_input.dart';
import '../widgets/uploader.dart';

class NewRecipeScreen extends StatefulWidget {
  static const routeName = "create-new-recipes";

  @override
  _NewRecipeScreenState createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final _form = GlobalKey<FormState>();
  // File _picked#Image;
  final _mealController = TextEditingController();
  _NewRecipeScreenState() {
    _mealController.addListener(_mealListen);
  }

  var _editedMeal = Meal(
    id: null,
    title: "",
    ingredients: [],
    steps: [],
    image: null,
  );
  var _initValues = {
    "title": "",
    "ingredients": [],
    "steps": [],
    "image": null,
  };
  var _isInit = true;
  var _isLoading = false;

  void _mealListen() {
    if (_mealController.text.isEmpty) {
      _initValues["title"] = "";
    } else {
      _initValues["title"] = _mealController.text;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final modalArgs = ModalRoute.of(context).settings.arguments as List;
      if (modalArgs[1] != null) {
        _editedMeal = Provider.of<Meals>(context, listen: false)
            .findById(modalArgs[1].id);
        _initValues = {
          "title": _editedMeal.title,
          "ingredients": _editedMeal.ingredients,
          "steps": _editedMeal.steps,
          "image": _editedMeal.image,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final modalArgs = ModalRoute.of(context).settings.arguments as List;
    // print(modalArgs);
    _mealController.text = _initValues["title"];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Erstelle dein neues Gericht",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 22,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
            color: Theme.of(context).backgroundColor.withOpacity(0.4),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      "Gebe dem Rezept einen Namen",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(41, 45, 50, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Form(
                      key: _form,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            maxLength: 50,
                            style: TextStyle(fontSize: 20, color: Color.fromRGBO(41, 45, 50, 1),),
                            controller: _mealController,
                            // textInputAction: TextInputAction.next,
                            // onFieldSubmitted: (value) {
                            //   if (_mealController.text == "") {
                            //     return;
                            //   } else {
                            //     _editedMeal = Meal(
                            //       id: _editedMeal.id,
                            //       title: value,
                            //       ingredients: _editedMeal.ingredients,
                            //       steps: _editedMeal.steps,
                            //       image: _editedMeal.image,
                            //     );
                            //     Navigator.of(context).pushNamed(
                            //       IngredientsScreen.routeName,
                            //       arguments: [
                            //         modalArgs[0],
                            //         modalArgs[1],
                            //         _editedMeal,
                            //       ],
                            //     );
                            //   }
                            // },
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return "Gebe bitte einen Namen ein.";
                            //   }
                            //   return null;
                            // },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ImageInput(imageName: _mealController.text),
                  // SizedBox(height: 150),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    alignment: FractionalOffset.bottomRight,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      splashColor: Theme.of(context).backgroundColor.withOpacity(0.8),
                      color: Colors.grey[200],
                      elevation: 4,
                      child: Text(
                        "Nächste Seite",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        StorageReference ref;

                        ref = FirebaseStorage.instance
                            .ref()
                            .child("images/" + _mealController.text + ".png");

                        Future<void> _downloadFile(StorageReference ref) async {
                          try {
                            String name = await ref.getDownloadURL();
                            // print(name);
                            _editedMeal = Meal(
                              id: _editedMeal.id,
                              title: _mealController.text,
                              ingredients: _editedMeal.ingredients,
                              steps: _editedMeal.steps,
                              image: name,
                            );
                            Navigator.of(context).pushNamed(
                              IngredientsScreen.routeName,
                              arguments: [
                                modalArgs[0],
                                modalArgs[1],
                                _editedMeal,
                              ],
                            );
                          } on Exception catch (e) {
                            print("Oops! the file was not found");

                            _editedMeal = Meal(
                              id: _editedMeal.id,
                              title: _mealController.text,
                              ingredients: _editedMeal.ingredients,
                              steps: _editedMeal.steps,
                              image:
                                  "https://firebasestorage.googleapis.com/v0/b/yourcookbook-b21f2.appspot.com/o/images%2FDefaultErrorHandlingImage.png?alt=media&token=879dc8b0-462d-4fe2-b5c2-f33465eb4862",
                            );
                            Navigator.of(context).pushNamed(
                              IngredientsScreen.routeName,
                              arguments: [
                                modalArgs[0],
                                modalArgs[1],
                                _editedMeal,
                              ],
                            );
                          }
                        }

                        if (_mealController.text == "") {
                          return;
                        } else {
                          _downloadFile(ref);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
