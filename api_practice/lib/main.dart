import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List listresponse;

  Future fetchdata() async {
    http.Response response;
    response = await http.get(
        'https://www.thegrowingdeveloper.org/apiview?id=4'); // send http request to the server using http.get()method

    if (response.statusCode == 200) {
      setState(() {
        listresponse = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fetch Data From Internet',
          // textAlign: TextAlign.end,
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: listresponse == null
          ? Container()
          : Text(
              listresponse[2].toString(),
              style: TextStyle(
                fontSize: 26.0,
              ),
            ),
    );
  }
}
