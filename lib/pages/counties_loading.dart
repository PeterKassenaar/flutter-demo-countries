import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesLoading extends StatefulWidget {
  @override
  _CountriesLoadingState createState() => _CountriesLoadingState();
}

class _CountriesLoadingState extends State<CountriesLoading> {
  @override
  Widget build(BuildContext context) {
    // Just an example loading screen. I'm mimicking network delay here
    // for 2 seconds then move on to the home screen.
    // In a real app you would fetch some data from a backend here and
    // navigate to the homepage once the data is loaded.
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });

    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        // TODO: implement
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              SpinKitFadingCircle(
                color: Colors.blueGrey[600],
                size: 50.0,
              ),
              Text('loading...')
            ],
          ),
        ));
  }
}
