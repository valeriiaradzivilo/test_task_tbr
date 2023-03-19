import 'package:flutter/material.dart';
import 'package:test_task_tbr/classes/country_class.dart';

SimpleDialog infoDialogue(BuildContext context, TextEditingController textController, Country chosenCountry)
{
  return SimpleDialog(
    title: const Text('Your phone number is'),
    children: <Widget>[
      dialogueOption("${chosenCountry.phoneCode}${textController.text}", context),
      dialogueOption("Country ${chosenCountry.name}", context),
      dialogueOption('Flag ${chosenCountry.flagEmoji}', context),
    ],
  );
}

SimpleDialogOption dialogueOption(String text, BuildContext context)
{
  return SimpleDialogOption(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text(text),
  );
}