import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 File ?selectedImage;
  var resJson;
   onUploadImage() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("Enter You API Url"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    setState(() {
      resJson = jsonDecode(response.body);
    });
  }
 Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("vjhg"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImage == null
                ? Text(
                    'Please Pick a image to Upload',
                  )
                : Image.file(selectedImage!),
            RaisedButton(
              color: Colors.green[300],
              onPressed: onUploadImage,
              child: Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(resJson['message'])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}