import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:test_task_tbr/api_work/country_api.dart';
import 'package:test_task_tbr/screens/countries_screen.dart';
import 'package:locale_emoji/locale_emoji.dart' as le;

import '../classes/country_class.dart';
import '../widgets/main_text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/';

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
  bool uploadedCountries = false;
  late Country chosenCountry;


  Future uploadCountries() async {
    countries = await countryAPI.getCountries();
    countries!.sort(countries!.elementAt(0).compareCountryName);
    setState(() {
      uploadedCountries = true;
      chosenCountry = countries!.elementAt(0);
    });
  }

  @override
  void initState() {
    uploadCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments!=null) {
      chosenCountry = ModalRoute.of(context)!.settings.arguments as Country;
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Visibility(
        visible: uploadedCountries,
        replacement: const Align(
            alignment: Alignment.center, child: CircularProgressIndicator()),
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              mainText("Get Started", true),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                countries != null
                    ? Container(
                        width: (0.3*width),
                        child: ListTile(
                            title: Text(
                                "${chosenCountry.flagEmoji} ${chosenCountry.phoneCode}"),
                            onTap: () => showCupertinoModalBottomSheet(
                                  expand: true,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => CountriesScreen(
                                    countries: countries!,
                                  ),
                                )),
                      )
                    : const SizedBox(),
                Container(
                  width: (0.5*width),
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
                      } else if(showButton) {
                        setState(() {
                          showButton = false;
                        });
                      }
                    },
                  ),
                ),
              ]),
          ],
        ),
            )),
      ),
    );
  }
}
