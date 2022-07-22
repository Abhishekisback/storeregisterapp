// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:storeregisterapp/dashboard.dart';

import 'package:storeregisterapp/product_list_by_store_id.dart';
import 'package:storeregisterapp/service/http_service.dart';
import 'package:storeregisterapp/signup.dart';

class addnewprod extends StatelessWidget {
  final userstoreid;
  String email_user, pass_word;
  addnewprod(
      {Key? key,
      required this.userstoreid,
      required this.email_user,
      required this.pass_word})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyImagePicker(
        user_storeid: userstoreid,
        email_user: email_user,
        pass_word: pass_word,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyImagePicker extends StatefulWidget {
  final user_storeid;
  String email_user, pass_word;
  MyImagePicker({
    Key,
    key,
    required this.user_storeid,
    required this.email_user,
    required this.pass_word,
  }) : super(key: key);

  @override
  _MyImagePickerState createState() => _MyImagePickerState(
        userstoreid_: user_storeid,
        email_user: email_user,
        pass_word: pass_word,
      );
}

class _MyImagePickerState extends State<MyImagePicker> {
  String userstoreid_;
  String email_user, pass_word;
  _MyImagePickerState(
      {Key? key,
      required this.userstoreid_,
      required this.email_user,
      required this.pass_word});

  final String uploadUrl = 'http://65.0.182.184/uploadproducts';
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  final formKey = GlobalKey<FormState>();
  final List<String> subjects = [
    "Meat Products",
    "Beverages",
    "Fruits and Vegetables",
    "Bakery",
    "Grocery",
    "select category"
  ];

  String sub = 'select category';
  String selectedSubject = "select category";
  String? responsed;
  String emailpattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  TextEditingController productname = TextEditingController();
  TextEditingController pprice = TextEditingController();
  TextEditingController pquantity = TextEditingController();
  TextEditingController productdescription = TextEditingController();

  Future<String> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('product_images', filepath));
    print(productname.text);
    print(productdescription.text);
    print(pprice.text);
    print(pquantity.text);
    request.fields['product_name'] = productname.text;
    request.fields['product_description'] = productdescription.text;
    request.fields['price'] = pprice.text;
    request.fields['quantity'] = pquantity.text;
    request.fields['category_name'] = sub.toString();
    request.fields['store_id'] = userstoreid_;

    var res = await request.send();
    print(request);
    return res.reasonPhrase.toString();
  }

  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      print('Retrieve error ' + response.exception!.code);
    }
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                  width: 200,
                  height: 300,
                  child: Image.file(File(_imageFile!.path))),
              onTap: _pickImage,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: productdescription,
                        maxLines: 8, //or null
                        decoration: InputDecoration.collapsed(
                            hintText: "Add Product Description here !"),
                        validator: (productdescription) {
                          if (productdescription!.isEmpty) {
                            return "Add Description";
                          } else {
                            print("Description\t"
                                '$productdescription');
                          }
                        }),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                onPrimary: Colors.white,
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.white70)),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  // if(sub!="select category")
                  if (sub != "select category") {
                    var res = await uploadImage(_imageFile!.path, uploadUrl);
                    responsed = res;
                    if (responsed == "OK") {
                      CircularProgressIndicator();
                      Future.delayed(Duration(seconds: 2), () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Server Response"),
                              content: Text("Product Added Successfully"),
                          
                            );
                          },
                        );
                        Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => dashboard())));
                        
                      });

                      productdescription.clear();
                      productname.clear();
                      pprice.clear();
                      pquantity.clear();
                      sub = "select category";
                    } else {
                       CircularProgressIndicator();
                      Future.delayed(Duration(seconds: 2), () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Server Response"),
                              content: Text("Error Occured While Adding product ??"),
                            );
                          },
                        );
                      });
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Required"),
                          content: Text("Please select the category field ?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ))
                          ],
                        );
                      },
                    );
                  }
                  // print("server response" + res);

                }
              },
              child: const Text(
                'Add Now',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          flexibleSpace: Image(
            image: AssetImage('lib/images/image2.jpeg'),
            fit: BoxFit.cover,
          ),
          title: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Add New Products ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          backgroundColor: Colors.amber.shade200,
        ),
      ),
      drawer: Drawer(
        width: 350,
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              accountName: Text(email_user.toString().substring(0, 4)),
              accountEmail: Text(email_user.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.pink.shade50,
                child: Text(email_user.toString().substring(0, 4)),
              ),
            ),
            ListTile(
              title: Text(
                "Recent Updates",
                textDirection: TextDirection.ltr,
              ),
              leading: Icon(Icons.update),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CardPage(storeid: userstoreid_)));
              },
            ),
            ListTile(
              title: Text("User Store Id:$userstoreid_",
                  textDirection: TextDirection.ltr),
              leading: Icon(Icons.more),
              onTap: () {},
            ),
            ListTile(
              title: Text('username :$email_user',
                  textDirection: TextDirection.ltr),
              leading: Icon(Icons.supervised_user_circle_sharp),
              onTap: () {},
            ),

            // ignore: prefer_const_constructors
            Divider(
              height: 10,
              thickness: 10,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            Center(
              child: Container(
                padding:
                    EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
                child: SizedBox(
                  width: 300,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 300,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(width: 5, color: Colors.blue),
                            )),
                            value: selectedSubject,
                            onChanged: (value) {
                              setState(() {
                                selectedSubject = value!;
                                if (value.toString() != "select category") {
                                  sub = value;
                                  print(sub);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Category Selected\n"),
                                        content: Text(
                                          sub,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 15),
                                              ))
                                        ],
                                      );
                                    },
                                  );
                                }
                              });
                            },
                            items:
                                subjects.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            initialValue: userstoreid_.toString(),
                            readOnly: true,
                            style: TextStyle(color: Colors.green),
                            decoration: InputDecoration(
                                labelText: "Store Id",
                                prefixIcon: Icon(Icons.mail_lock),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0))),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: productname,
                            style: TextStyle(color: Colors.green),
                            decoration: InputDecoration(
                                labelText: "Enter Product Name",
                                prefixIcon:
                                    Icon(Icons.production_quantity_limits),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0))),
                            validator: (productname) {
                              if (productname!.isEmpty ||
                                  productname == null ||
                                  !RegExp(r'').hasMatch(productname)) {
                                return " Enter  Product Name";
                              } else {
                                print("Mail\t" '$productname');
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: pprice,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.green),
                            decoration: InputDecoration(
                                labelText: "Enter Product Price",
                                prefixIcon: Icon(Icons.price_check_sharp),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0))),
                            validator: (pprice) {
                              if (pprice!.isEmpty) {
                                return " Enter Price ";
                              } else {
                                print("Mail\t" '$pprice');
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: pquantity,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.green),
                            decoration: InputDecoration(
                                labelText: "Enter Product Quantity ",
                                prefixIcon:
                                    Icon(Icons.production_quantity_limits),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0))),
                            validator: (pquantity) {
                              if (pquantity!.isEmpty) {
                                return "Enter Quantity";
                              } else {
                                print("Password\t" '$pquantity');
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.photo_album_rounded,
                              size: 30,
                            ),
                            label: Text("Pick From Galery "),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                              onPrimary: Colors.white,
                              minimumSize: Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.white70)),
                            ),
                            onPressed: () {
                              _pickImage();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: FutureBuilder<void>(
                          future: retriveLostData(),
                          builder: (BuildContext context,
                              AsyncSnapshot<void> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return const Text('Picked an image');
                              case ConnectionState.done:
                                return _previewImage();
                              default:
                                return const Text('Picked an image');
                            }
                          },
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        /*ElevatedButton(onPressed: () async{
                                  await  productbystore(userstoreid_);
                          }, child: Text("get product")),*/
                        SizedBox(
                          height: 30,
                        ),
                        /*ElevatedButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>editstoreproducts(storeid: userstoreid_,)));
                           }, child: Text(" edit")),*/
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //  Center(child: Text("Follow Us")),
            /*    Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook),
                  Icon(Icons.apple),
                ],
              ),
            ),*/
            SizedBox(
              height: 40,
            ),

            /*  floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image from gallery',
        child: Icon(Icons.photo_library),
      ),*/
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
