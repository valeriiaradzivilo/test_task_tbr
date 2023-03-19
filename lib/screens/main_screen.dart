import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_tbr/api_work/country_api.dart';
import 'package:test_task_tbr/main.dart';
import 'package:test_task_tbr/screens/countries_screen.dart';
import '../classes/country_class.dart';
import '../widgets/main_text.dart';
import '../widgets/simple_dialogue.dart';
import '../widgets/white_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Color backgroundColor ;
  final TextEditingController _phoneController = TextEditingController();
  bool showButton = false;
  List<Country>? countries;
  CountryAPI countryAPI = CountryAPI();
  bool uploadedCountries = false;
  late Country chosenCountry;

  Future uploadCountries() async {
    countries = await countryAPI.getCountries();
    if (countries != null) {
      countries!.sort(countries!.elementAt(0).compareCountryName);
      setState(() {
        chosenCountry = countries!.elementAt(0);
        uploadedCountries = true;
      });
    }
  }

  @override
  void initState() {
    backgroundColor = MyApp.backgroundColor;
    uploadCountries();
    getUserCountryLocation();
    super.initState();
  }

  Future<void> getUserCountryLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    List<Placemark> pl = await placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);

    countries?.forEach((element) {
      if (element.name.toLowerCase() == pl[0].country!.toLowerCase() ||
          element.fullName.toLowerCase() == pl[0].country!.toLowerCase()) {
        setState(() {
          chosenCountry = element;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.arguments != null) {
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
                      return infoDialogue(
                          context, _phoneController, chosenCountry);
                    });
              }
            : null,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: showButton ? Colors.white : Colors.white30,
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
                              30.w,
                              ListTile(
                                  title: Text(
                                      "${chosenCountry.flagEmoji} ${chosenCountry.phoneCode}"),
                                  onTap: () => showCupertinoModalBottomSheet(
                                        expand: false,
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => CountriesScreen(
                                          countries: countries!,
                                        ),
                                      )),
                            )
                          : const SizedBox(),
                      whiteContainer(
                        50.w,
                        MaskedTextField(
                            maxLines: 1,
                            mask: "(###) ###-####",
                            controller: _phoneController,
                            maxLength: 14,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: const InputDecoration(
                                hintText: "Your phone number",
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding: EdgeInsets.only(left: 15)),
                            onChanged: (value) {
                              if (value.length == 14 ||
                                  (value.length < 14 && showButton)) {
                                setState(() {
                                  showButton =
                                      _phoneController.text.length == 14;
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
