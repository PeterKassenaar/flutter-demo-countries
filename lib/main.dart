import 'package:flutter/material.dart';

// custom pages in this app
import 'package:flutter_countries/pages/counties_loading.dart';
import 'package:flutter_countries/pages/countries_home.dart';
import 'package:flutter_countries/pages/countries_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CountriesLoading(),
        '/home': (context) => CountriesHome(),
        '/detail': (context) => CountriesDetail(),
      },
    );
  }
}


