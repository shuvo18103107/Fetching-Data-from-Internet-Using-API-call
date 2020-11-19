import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  String stringresponse;

  Future fetchdata() async {
    http.Response response;
    response = await http.get(
        'https://www.thegrowingdeveloper.org/apiview?id=1'); // send http request to the server using http.get()method

    if (response.statusCode == 200) {
      setState(() {
        stringresponse = response.body;
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
      body: Text(
        stringresponse.toString(),
        style: TextStyle(
          fontSize: 25.0,
        ),
      ),
    );
  }
}
