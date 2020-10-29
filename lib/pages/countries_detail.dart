import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

class CountriesDetail extends StatefulWidget {
  @override
  _CountriesDetailState createState() => _CountriesDetailState();
}

class _CountriesDetailState extends State<CountriesDetail> {
  Map routingData = {};
  String countryName = '';
  List countries = [];

  String url = 'https://restcountries.eu/rest/v2/name/';

  void getCountry(name) async {
    Response response = await get(url + name);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        countries = jsonDecode(response.body);
      });
    } else {
      setState(() {
        countries = [
          {'name': 'Error', 'capital': 'Not found...'}
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    routingData = ModalRoute.of(context).settings.arguments;
    countries.length == 0 ? getCountry(routingData['name']) : null;

    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          title: Text(routingData['name']),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: countries.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SvgPicture.network(
                    countries[index]['flag'],
                    width: 240,
                  ),
                ),
                Divider(
                  height: 40,
                  color: Colors.blueGrey,
                ),
                Text(
                  'NAME:',
                  style: TextStyle(color: Colors.grey, letterSpacing: 2),
                ),
                SizedBox(height: 10),
                Text(countries[0]['name']),
                Text('(native: ${countries[0]['nativeName']})'),
                SizedBox(height: 20),
                Text(
                  'CAPITAL:',
                  style: TextStyle(color: Colors.grey, letterSpacing: 2),
                ),
                Text(countries[0]['capital']),
                SizedBox(height: 20),
                Text(
                  'POPULATION:',
                  style: TextStyle(color: Colors.grey, letterSpacing: 2),
                ),
                Text(countries[0]['population'].toString()),
                SizedBox(height: 20),
                Text(
                  'REGION:',
                  style: TextStyle(color: Colors.grey, letterSpacing: 2),
                ),
                Text('${countries[0]['region']} /  ${countries[0]['subregion']}'),
                SizedBox(height: 20),
                Text(
                  'CALLING CODE(S):',
                  style: TextStyle(color: Colors.grey, letterSpacing: 2),
                ),
                Text('${countries[0]['callingCodes']}'),
              ],
            );
          },
        ));
  }
}
