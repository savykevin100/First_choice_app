import 'package:flutter/material.dart';



Future<bool> onBackPressed(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit an App'),
      actions: <Widget>[
        new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("Non", style: TextStyle(fontFamily: "MonseraBold"),)
        ),
        new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("Oui", style: TextStyle(fontFamily: "MonseraBold"),)
        ),
      ],
    ),
  ) ??
      false;
}
