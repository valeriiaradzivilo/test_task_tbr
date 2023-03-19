import 'package:flutter/material.dart';
import 'package:test_task_tbr/classes/country_class.dart';

SimpleDialog infoDialogue(BuildContext context, TextEditingController textController, Country chosenCountry)
{
  return SimpleDialog(
    title: const Text('Your phone number is'),
    children: <Widget>[
      SimpleDialogOption(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
            "${chosenCountry.phoneCode}${textController.text}"),
      ),
      SimpleDialogOption(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Country ${chosenCountry.name}'),
      ),
      SimpleDialogOption(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Flag ${chosenCountry.flagEmoji}'),
      ),
    ],
  );
}