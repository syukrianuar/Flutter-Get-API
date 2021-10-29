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

class DataFromAPI extends StatefulWidget {
  const DataFromAPI({ Key? key }) : super(key: key);
  
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  getUserData() async{
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for(var u in jsonData){
      User user = User(u["name"], u["email"], u["username"]);
      users.add(user);
    }
    print(users.length);
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
          builder: (context, snapshot){
            if(snapshot.data == null){
              return Container(
                child: const Center(
                  child: Text('Loading...'),
                ),
              );
            }else 
            return ListView.builder(
              // itemCount: snapshot.data.length,
              itemBuilder: (context, i){
                return ListTile(
                  // title: Text(snapshot.data[i].name),
                  // subtitle: Text(snapshot.data[i].userame),
                  // trailing: Text(snapshot.data[i].email),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}

class User{
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}

