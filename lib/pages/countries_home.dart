import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart'; //to handle .svg-images from the API

class CountriesHome extends StatefulWidget {
  @override
  _CountriesHomeState createState() => _CountriesHomeState();
}

class _CountriesHomeState extends State<CountriesHome> {
  // variables in this Widget
  final textController = TextEditingController();
  String url = 'https://restcountries.eu/rest/v2/name/';
  String fields =
      '?fields=name;capital;flag'; // TODO: create a Model for a country
  String countryName = '';
  List countries = [];

  void getCountries(String name) async {
    Response response = await get(url + name + fields);
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      setState(() {
        countries = jsonResponse;
      });
    } else if (response.statusCode == 404) {
      setState(() {
        countries = [
          {'name': 'error', 'capital': 'not found', 'flag': ''}
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = 'Flutter Country Picker';
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: FlutterLogo(),
        title: Text(title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: textController,
                  decoration: InputDecoration(hintText: 'Search countries...'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text('Clear'),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          countryName = '';
                          textController.text = '';
                          countries = []; // reset array with countries
                        });
                      },
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.search),
                      label: Text('Search'),
                      color: Colors.green,
                      onPressed: () {
                        print(textController.text);
                        getCountries(textController.text);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(9),
                itemCount: countries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: SvgPicture.network(
                            // using a 3rd party package here instead of CircleAvatar(),
                            // as Flutter can't handle .svg-images (yet?).
                            countries[index]['flag'],
                            width: 64,
                          ),
                          title: Text(countries[index]['name']),
                          subtitle: Text(countries[index]['capital']),
                          onTap: () {
                            // navigate to detail page
                            Navigator.pushNamed(context, '/detail',
                                arguments: {'name': countries[index]['name']});
                          },
                        ),
                        Divider(
                          height: 4,
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
