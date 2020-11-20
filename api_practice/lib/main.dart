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
  Map mapresponse;
  List listoffacts;

  Future fetchdata() async {
    http.Response response;
    response = await http.get(
        'https://www.thegrowingdeveloper.org/apiview?id=2'); // send http request to the server using http.get()method

    if (response.statusCode == 200) {
      setState(() {
        mapresponse = jsonDecode(response.body);
        listoffacts = mapresponse['facts'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
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
      body: mapresponse == null
          ? Container()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    mapresponse['category'],
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Image.network(listoffacts[index]['image_url']),
                            Text(
                              listoffacts[index]['title'].toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              listoffacts[index]['description'].toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: listoffacts == null ? 0 : listoffacts.length,
                  )
                ],
              ),
            ),
    );
  }
}
