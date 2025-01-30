import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';



Future<Album> fetchLogin() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
     required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
       'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: fdfdf(),
      routes: {
        'second': (context) => const SecondPage(),
      },
    );
    
  }
}

class fdfdf extends StatefulWidget {
  const fdfdf({super.key});

  @override
  State<fdfdf> createState() => _fdfdfState();
}

class _fdfdfState extends State<fdfdf> {
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [IconButton(onPressed: (){
          Navigator.of(context).pushNamed('second');
        } , icon:Icon(Icons.login))],
      ),
    );
    
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchLogin();
  }
  late Future<Album> futureAlbum;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [FutureBuilder<Album>(
  future: futureAlbum,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data!.title);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  },
)])
    
;
  }
}