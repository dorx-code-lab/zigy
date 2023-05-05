import 'package:flutter/material.dart';

class CommunicationServices {
  showSnackBar(String message, BuildContext context,
      {Function whatToDo, String buttonText, SnackBarBehavior behavior}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: behavior,
        action: whatToDo == null
            ? null
            : SnackBarAction(
                label: buttonText,
                onPressed: whatToDo,
              ),
      ),
    );
  }
}
