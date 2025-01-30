import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title, String content) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8080/api/articles'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'content':content,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String title;
  final String content;

  const Album({ required this.title, required this.content});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'content':String content,
      } =>
        Album(
          title: title,
          content: content,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        TextField(
          controller: _controller2,
          decoration: const InputDecoration(hintText: 'Enter Content'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text,_controller2.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}



// import 'dart:ffi';

// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/material.dart';



// Future<Album> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }
// class Album {
//   final int id;
//   final String title;

//   const Album({required this.id, required this.title});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'id': int id,
//         'title': String title,
//       } =>
//         Album(
//           id: id,
//           title: title,
//         ),
//       _ => throw const FormatException('Failed to load album.'),
//     };
//   }
// }
// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: fdfdf(),
//       routes: {
//         'second': (context) => const SecondPage(),
//       },
//     );
    
//   }
// }

// class fdfdf extends StatefulWidget {
//   const fdfdf({super.key});

//   @override
//   State<fdfdf> createState() => _fdfdfState();
// }

// class _fdfdfState extends State<fdfdf> {
  

  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [IconButton(onPressed: (){
//           Navigator.of(context).pushNamed('second');
//         } , icon:Icon(Icons.login))],
//       ),
//     );
    
//   }
// }

// class SecondPage extends StatefulWidget {
//   const SecondPage({super.key});

//   @override
//   State<SecondPage> createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {

//   final TextEditingController _controller = TextEditingController();
//   late Future<Album> _futureAlbum;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//   children: <Widget>[
//     TextField(
//       controller: _controller,
//       decoration: const InputDecoration(hintText: 'Enter Title'),
//     ),
//     ElevatedButton(
//       onPressed: () {
//         setState(() {
//           _futureAlbum = createAlbum(_controller.text);
//         });
//       },
//       child: const Text('Create Data'),
//     ),
//   ],
//       )
    
// ;
//   }
// }