import 'package:flutter/material.dart';

import '../classes/country_class.dart';

Form searchBar(TextEditingController controller, onChangedFunction) {
  return Form(
    child: TextField(
      controller: controller,
      onChanged: (value) {
        onChangedFunction(value);

      },
    ),
  );
}
