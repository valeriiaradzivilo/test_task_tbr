import 'package:flutter/material.dart';

Padding mainText(String text, bool isBig)
{
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text(text,style: TextStyle(
      fontSize: isBig?30:16,
      color: Colors.white,
      fontWeight: isBig?FontWeight.bold:FontWeight.w400
    ),
      textAlign: TextAlign.left,
    ),
  );
}
