import 'dart:convert';

List<Country> commentFromJson(String str) => List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));
class Country{
  String phoneCode;
  String name;
  String fullName;
  String flagEmoji;


  Country(this.phoneCode,this.name,this.fullName,this.flagEmoji);
  
  
  Country baseCounty ()
  {
    return Country("+380", "Ukraine", "Ukraine", "\uD83C\uDDFA\uD83C\uDDE6");
  }

  factory Country.fromJson(Map<String,dynamic> jsonResult) => Country(
      "${jsonResult["idd"]["root"]}${jsonResult["idd"]["suffixes"]!=null?jsonResult["idd"]["suffixes"][0]:""}",
      jsonResult["name"]["common"],
      jsonResult["name"]["official"],
      jsonResult["flag"]);

  @override
  String toString()
  {
    return "$phoneCode\n $name\n $fullName\n";
  }

  int compareCountryName(Country a, Country b) {
    return a.fullName.compareTo(b.fullName);
  }




}