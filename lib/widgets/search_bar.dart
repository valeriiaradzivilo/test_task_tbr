import 'package:flutter/material.dart';

import '../classes/country_class.dart';

Form searchBar(TextEditingController controller, List<Country>listOfCountries, List<Country> copyOfList)
{
  return Form(
    child: TextField(
      controller: controller,
      onChanged: (value)
      {
        if(value=="")
          {
            copyOfList=[...listOfCountries];
          }
        else {
          copyOfList.clear();
          for (int i =0; i<listOfCountries.length;i++) {
            Country c = listOfCountries.elementAt(i);
            if (c.fullName.toLowerCase().contains(value) ||
                c.name.toLowerCase().contains(value)) {
              copyOfList.add(c);
              print(c.toString());
            }
          }
        }
        },
    ),
  );
}