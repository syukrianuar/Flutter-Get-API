import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DataFromAPI(),      
    );
  }
}

class User{
  final String name; 
  final String email;
  final String username;

  User({
    required this.name, 
    required this.email, 
    required this.username,
  });
}

class DataFromAPI extends StatefulWidget {
  const DataFromAPI({ Key? key }) : super(key: key);
  
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  Future<List<User>> getUserData() async{
    String url = "https://jsonplaceholder.typicode.com/users";
    final response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);
    List<User> users = [];

    for(var u in jsonData){
      User user = User(
        name: u["name"], 
        email: u["email"], 
        username: u["username"]);
      users.add(user);
    }
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: Container(
        child: Card(child: FutureBuilder(
          future: getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: const Center(
                  child: Text('Loading...'), Text('Loading...'),
                ),
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i)=>ListTile(
                    title: Text(snapshot.data[i].name),
                    subtitle: Text(snapshot.data[i].username),
                    trailing: Text(snapshot.data[i].email),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

