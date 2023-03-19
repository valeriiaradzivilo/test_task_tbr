import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_tbr/screens/main_screen.dart';
import 'package:test_task_tbr/widgets/main_text.dart';
import 'package:test_task_tbr/widgets/search_bar.dart';
import 'package:test_task_tbr/widgets/white_container.dart';

import '../classes/country_class.dart';
import '../main.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key, required this.countries}) : super(key: key);
  final List<Country>? countries;
  static const routeName = '/countries';
  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  late Color backgroundColor;
  List<Country> copyOfCountries = []; // this copy os required for search
  TextEditingController searchController = TextEditingController(); // controls search input

  @override
  void initState() {
    backgroundColor = MyApp.backgroundColor;
    copyOfCountries = [...widget.countries!];
    super.initState();
  }

  onChangedSearch(value) {
    if (value == "") {
      copyOfCountries = [...widget.countries!];
    } else {
      copyOfCountries.clear();
      for (int i = 0; i < widget.countries!.length; i++) {
        Country c = widget.countries!.elementAt(i);
        if (c.fullName.toLowerCase().contains(value.toString().toLowerCase()) ||
            c.name.toLowerCase().contains(value.toString().toLowerCase()) ||
            c.phoneCode.contains(value)) {
          copyOfCountries.add(c);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: mainText("Country code", true),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
      body: Column(
        children: [
          whiteContainer(90.w, searchBar(searchController, onChangedSearch)),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, MainScreen.routeName,
                            arguments: copyOfCountries.elementAt(index));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text(
                                  "${copyOfCountries.elementAt(index).flagEmoji}  ${copyOfCountries.elementAt(index).phoneCode} ")),
                          Expanded(
                              child: mainText(
                                  copyOfCountries.elementAt(index).name,
                                  false)),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: copyOfCountries.length),
          ),
        ],
      ),
    );
  }
}
