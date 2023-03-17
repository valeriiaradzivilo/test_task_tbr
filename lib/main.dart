import 'package:flutter/material.dart';
import 'package:test_task_tbr/screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(isLocationEnabled: false));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLocationEnabled});
  final bool isLocationEnabled;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MainScreen(isLocationEnabled: isLocationEnabled,),
    );
  }
}
