import 'package:flutter/material.dart';

class Helper {
  showSnackBar(BuildContext context, String message) {
    var snakBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snakBar);
  }
}
