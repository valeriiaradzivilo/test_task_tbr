import 'dart:convert';

List<Country> countryFromJson(String str) => List<Country>.from(json.decode(str).map((x) =>
Country.fromJson(x)).where((c) => c.phoneCode != "null"));
class Country{
  String phoneCode;
  String name;
  String fullName;
  String flagEmoji;


  Country(this.phoneCode,this.name,this.fullName,this.flagEmoji);


  factory Country.fromJson(Map<String,dynamic> jsonResult){
    return Country(
        "${jsonResult["idd"]["root"]}${jsonResult["idd"]["suffixes"] != null
            ? jsonResult["idd"]["suffixes"][0]
            : ""}",
        jsonResult["name"]["common"],
        jsonResult["name"]["official"],
        jsonResult["flag"]);
  }

  @override
  String toString()
  {
    return "$phoneCode\n $name\n $fullName\n";
  }

  int compareCountryName(Country a, Country b) {
    return a.name.compareTo(b.name);
  }




}