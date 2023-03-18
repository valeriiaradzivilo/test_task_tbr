import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/country_class.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key, required this.countries}) : super(key: key);
  final List<Country> countries;
  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  Color backgroundColor = const Color(0xFF8eaafb);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Countries"),
      ),
      body: Column(
        children: [
          Text("Search"),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width:80,
                            child: Text("${widget.countries.elementAt(index).flagEmoji}  ${widget.countries.elementAt(index).phoneCode} ")),
                        Expanded(
                            child: Text(
                          widget.countries.elementAt(index).fullName,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )),
                      ],
                    ),
                  );
                },
                itemCount: widget.countries.length),
          ),
        ],
      ),
    );
  }
}
