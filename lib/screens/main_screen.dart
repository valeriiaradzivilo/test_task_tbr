import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:test_task_tbr/api_work/country_api.dart';
import 'package:test_task_tbr/screens/blank_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.isLocationEnabled}) : super(key: key);
  final bool isLocationEnabled;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color backgroundColor = const Color(0xFF8eaafb);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  bool showButton = false;
  List<Country>? countries;
  CountryAPI countryAPI = CountryAPI();

  Future uploadCountries() async
  {
    countries = await countryAPI.getCountries();
  }



  @override
  void initState() {
    uploadCountries();
    super.initState();
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          const Text("Get Started"),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton.icon(
                onPressed: () {
                  showCountryPicker(
                    context: context,
                    countryListTheme: CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: backgroundColor,
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      bottomSheetHeight:
                          500, // Optional. Country list modal height
                      //Optional. Sets the border radius for the bottomsheet.
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    showPhoneCode:
                        true, // optional. Shows phone code before the country name.
                    onSelect: (Country country) {
                      print('Select country: ${country.displayName}');
                      // selectedCountry = country;
                    },
                    useSafeArea: true,
                  );
                },
                icon: Text("s"),
                label: Text("ss")),
            Container(
              width: 200,
              child: Form(
                key: _formKey,
                child: MaskedTextField(
                  mask: "(###) ###-####",
                  controller: _textController,
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                onChanged: () {
                  if (_textController.text.length == 10) {
                    setState(() {
                      showButton = true;
                    });
                  } else {
                    setState(() {
                      showButton = false;
                    });
                  }
                },
              ),
            ),
          ]),
          ListTile(
              title: const Text('Cupertino Modal with inside navigation'),
              onTap: () => showCupertinoModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const BlankScreen(),
                  )),
        ],
      )),
    );
  }
}
