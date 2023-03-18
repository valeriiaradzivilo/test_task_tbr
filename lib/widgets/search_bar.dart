import 'package:flutter/material.dart';

Form searchBar(TextEditingController controller, onChangedFunction) {
  return Form(
    child: TextField(
      controller: controller,
      onChanged: (value) {
        onChangedFunction(value);
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search),
        hintText: "Search",
        hintStyle: TextStyle(
          fontSize: 20
        )
      ),
    ),
  );
}
