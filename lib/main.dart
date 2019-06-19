import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(
    new MaterialApp(
      home: new HomePage(),
    )
  );
}

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{

  var string_data="";

  //untuk medapatkan data dari internet, kita pake async, dan me return String
  Future<String> getData() async{
    http.Response response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept" : "application/json"
      }
    );

    //untuk print response
    // print(response.body);

    List data = json.decode(response.body);
    // print(data);

    print(data[1]["title"]);
    //hasilnya title: "qui est esse"

    //kirim value ke variable
    setState(() {
      string_data = data[1]["title"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Stateful Widget"),
        backgroundColor: Colors.lightBlue,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                child: new Text(
                  "Get Data!",
                  style: new TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0
                  ),
                ),
                onPressed: getData,
              ),
              new Text(string_data)
            ],
          ),
        ),
      ),
    );
  }
}