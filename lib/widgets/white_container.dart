import 'package:flutter/material.dart';

Padding whiteContainer(double width, Widget child) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      alignment: Alignment.center,
        height: 60,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white30, borderRadius: BorderRadius.circular(18)),
        child: child),
  );
}
