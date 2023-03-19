import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_tbr/api_work/country_api.dart';
import 'package:test_task_tbr/screens/countries_screen.dart';
import '../classes/country_class.dart';
import '../widgets/main_text.dart';
import '../widgets/white_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color backgroundColor = const Color(0xFF8eaafb);
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
    if (ModalRoute.of(context)!.settings.arguments != null) {
      chosenCountry = ModalRoute.of(context)!.settings.arguments as Country;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: mainText("Get Started", true),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showButton
            ? () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text('Your phone number is'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("${chosenCountry.phoneCode}${_textController.text}"),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Country ${chosenCountry.name}'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Flag ${chosenCountry.flagEmoji}'),
                    ),
                  ],
                );
              });
              }
            : null,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: showButton?Colors.white:Colors.white30,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.blueGrey,
        ),
      ),
      body: Visibility(
          visible: uploadedCountries,
          replacement: const Align(
              alignment: Alignment.center, child: CircularProgressIndicator()),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      countries != null
                          ? whiteContainer(
                              25.w,
                              ListTile(
                                  contentPadding: EdgeInsets.only(left: 20),
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
                      whiteContainer(
                        55.w,
                        MaskedTextField(
                            maxLines: 1,
                            mask: "(###) ###-####",
                            controller: _textController,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: const InputDecoration(
                                hintText: "Your phone number",
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(top: 5, left: 15)),
                            onChanged: (value) {
                              if(value.length==14||(value.length<14&&showButton)) {
                                setState(() {
                                  showButton =
                                      _textController.text.length == 14;
                                });
                              }
                            }),
                      ),
                    ]),
              ),
            ),
          )),
    );
  }
}
