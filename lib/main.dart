import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_task_tbr/screens/countries_screen.dart';
import 'package:test_task_tbr/screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType)
    {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const MainScreen(),
          '/countries': (context) => const CountriesScreen(countries: null),
        },
      );
    }
    );
  }
}
