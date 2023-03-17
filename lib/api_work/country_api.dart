import 'package:country_picker/country_picker.dart';
import 'package:http/http.dart' as http;
class CountryAPI{
  static String baseUrl = 'https://restcountries.com/v3.1/all';
  static String nameEndpoint = '/name';


  Future <List<Country>?> getCountries ()async{
    try{
      var url = Uri.parse(baseUrl);
      var result = await http.get(url);
      if (result.statusCode == 200)
        {
          print(result);
        }
      print(result.statusCode);
    }catch(e)
    {
      print("Error: $e");
    }
    return null;
  }

}