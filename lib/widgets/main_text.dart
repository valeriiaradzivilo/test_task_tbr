import 'package:flutter/material.dart';

Text mainText(String text, bool isBig)
{
  return Text(text,style: TextStyle(
    fontSize: isBig?30:16,
    color: Colors.white,
    fontWeight: isBig?FontWeight.bold:FontWeight.w400
  ),
    textAlign: TextAlign.left,
  );
}
