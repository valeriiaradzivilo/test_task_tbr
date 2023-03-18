import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task_tbr/screens/main_screen.dart';
import 'package:test_task_tbr/widgets/main_text.dart';
import 'package:test_task_tbr/widgets/search_bar.dart';

import '../classes/country_class.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key, required this.countries}) : super(key: key);
  final List<Country>? countries;
  static const routeName = '/countries';
  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  Color backgroundColor = const Color(0xFF8eaafb);
  List<Country> copyOfCountries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
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
        if (c.fullName.toLowerCase().contains(value) ||
            c.name.toLowerCase().contains(value)) {
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
      ),
      body: Column(
        children: [
          searchBar(searchController, onChangedSearch),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return Padding(
                    key: UniqueKey(),
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, MainScreen.routeName,
                            arguments: copyOfCountries.elementAt(index));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
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