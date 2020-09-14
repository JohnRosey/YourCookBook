import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './uploader.dart';

class ImageInput extends StatefulWidget {
  final String imageName;

  ImageInput({Key key, this.imageName}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final selected = await ImagePicker.pickImage(source: source, maxWidth: 1600);

    if (selected == null) {
      return;
    }
    setState(
      () {
        _imageFile = selected;
      },
    );
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          // color: Theme.of(context).primaryColorLight,
          width: 200,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _imageFile != null
              ? Stack(
                  children: <Widget>[
                    Image.file(
                      _imageFile,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColorLight,
                          // borderRadius: BorderRadius.circular(10),
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // color: Theme.of(context).hintColor,
                          textColor: Colors.red[800],
                          child: Icon(
                            Icons.delete,
                            size: 25,
                          ),
                          onPressed: _clear,
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
                  "Kein Bild vorhanden",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromRGBO(41, 45, 50, 1), fontSize: 18),
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 25,
        ),
        Expanded(
          child: _imageFile == null
              ? FlatButton.icon(
                  icon: Icon(
                    Icons.photo_camera,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(""),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () => _pickImage(ImageSource.camera),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(
                        Icons.photo_camera,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(""),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Uploader(
                      file: _imageFile,
                      imageName: widget.imageName,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
