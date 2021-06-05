import 'dart:convert';
import 'dart:io' as Io;
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    final bytes = await pickedFile.readAsBytes();
    String img64 = base64Encode(bytes);

    setState(() {
      if (pickedFile != null) {
        if (kIsWeb) {
          image = Image.network(pickedFile.path);
        } else {
          image = Image.file(Io.File(pickedFile.path));
        }
      } else {
        print('No image selected.');
      }
    });

    print(img64);
  }

  @override
  Widget build(BuildContext context) {
    var flag = -1;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Puthon - Validator",
              style: TextStyle(
                color: Colors.white70,
                fontSize: MediaQuery.of(context).size.shortestSide * .07,
                fontWeight: FontWeight.bold,
              ),
            ),
            image == null
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: getImage,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Pick Image"),
                    ),
                  )
                : Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .4,
                          child: image == null ? SizedBox() : image,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SpinKitFadingCircle(
                        color: Colors.white60,
                        size: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Validating... Please wait...",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
