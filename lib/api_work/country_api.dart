import 'package:http/http.dart' as http;

import '../classes/country_class.dart';
class CountryAPI{
  static String baseUrl = 'https://restcountries.com/v3.1/all';

  Future <List<Country>?> getCountries ()async{
    try{
      var url = Uri.parse(baseUrl);
      var result = await http.get(url);
      if (result.statusCode == 200)
        {
          var json = result.body;
          return countryFromJson(json);
        }
    }catch(e)
    {
      print("Error: $e");
    }
    return null;
  }

}