import 'package:flutter/material.dart';
import 'package:foodapp/home.dart';
import 'package:foodapp/splash.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool done=true;
  void loadScreen(){
    Future.delayed(const Duration(seconds: 5),(){
      setState(() {
        done=false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadScreen();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Macipie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: done?const Splash():const HomeScreen(),
    );
  }
}
