import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  final File file;
  String imageName;

  Uploader({Key key, this.file, @required this.imageName}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  DateTime time;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://yourcookbook-b21f2.appspot.com");

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = "images/" + widget.imageName + ".png";

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete) Text("Gespeichert"),
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              LinearProgressIndicator(
                value: progressPercent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColorLight,
                ),
              ),
              Text(
                "${(progressPercent * 100).toStringAsFixed(2)} % ",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(
        label: Text(""),
        icon: Icon(Icons.save, size: 40),
        onPressed: _startUpload,
      );
    }
  }
}
