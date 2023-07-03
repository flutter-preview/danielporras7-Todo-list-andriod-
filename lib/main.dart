import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_list/take_picture_page.dart';
import 'package:path/path.dart' as p;
import 'FirebaseLogin.dart';
import 'todos_list.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {



  void _changePage() {
    setState(() async {

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TodosList(title: "ToDo List"))
      );
    });
  }
  void _changePage2() {
    setState(() async {

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginDemo())
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.blueAccent,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white,
      body:  Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

        Container(
          width: 300,

          child: Image.network('https://cdn.shopify.com/s/files/1/0763/0897/products/'
              'NP709_web_angle_ee14ac2c-82bc-4593-b8ec-2c4009a97cc0_1024x1024@2x.png?v=1603472650'),
        ),
            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,


                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Shared Link',
                      ),

                    ),
                  ),
                )),


            Expanded(
                child: Align(

                    alignment: Alignment.center,

                    child: OutlinedButton(

                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black, // foreground
                        ),
                        onPressed:_changePage2,
                        child: const Text('Login')
                    ))),




        Expanded(
            child: Align(

              alignment: Alignment.topCenter,

            child: TextButton(

          style: TextButton.styleFrom(
          backgroundColor: Colors.black, // foreground
        ),
        onPressed:_changePage,

        child: const Text('Create New')
        ))),




          ],
        )
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


