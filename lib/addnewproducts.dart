import 'dart:io';

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyImagePicker());
    
  }
}

class MyImagePicker extends StatefulWidget {
  MyImagePicker({Key, key}) : super(key: key);

  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  PickedFile ?_imageFile;
  final String uploadUrl = 'http://13.233.238.236/uploadproducts';
  final ImagePicker _picker = ImagePicker();
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
    request.fields['category_name'] = "Fruits and Vegetables";
    request.fields['store_id'] = "Static title";

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
            Container(
              width: 300,
              height: 300,
              child: Image.file(File(_imageFile!.path))),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                
                var res = await uploadImage(_imageFile!.path, uploadUrl);
                print("hgfhfg" + res);
                
              },
              child: const Text('Add Now'),
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
      appBar: AppBar(
        title: Text("A Image"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
               SizedBox(
                 height: 20,
               ),
               SizedBox(
                 height: 10,
               ),
               Container(
                 child: Row(
                   children: [
                     Spacer(),
                     Text(
                       "",
                       style: TextStyle(
                         fontSize: 18,
                         color: Color.fromARGB(255, 232, 35, 62),
                         fontStyle: FontStyle.italic,
                         decoration: TextDecoration.underline,
                       ),
                     ),
                   ],
                 ),
              ),
               SizedBox(
                 height: 30,
               ),
               SizedBox(
                 height: 5,
               ),
               Center(
                 child: Container(
                   padding: EdgeInsets.only(
                       left: 50, right: 50, top: 10, bottom: 10),
                   decoration: BoxDecoration(
                     border: Border.all(),
                     borderRadius: BorderRadius.circular(5.0),
                   ),
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
                                         return SimpleDialog(
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.all(
                                                 Radius.circular(10.0)),
                                           ),
                                           title: Text(sub),
                                           backgroundColor: Colors.white,
                                           contentPadding:
                                               EdgeInsets.all(40.0),
                                         );
                                       },
                                     );
                                   }
                                 });
                               },
                               items: subjects
                                   .map<DropdownMenuItem<String>>((value) {
                                 return DropdownMenuItem(
                                 child: Text(value),
                                   value: value,
                                 );
                               }).toList(),
                             ),
                           ),
                           SizedBox(
                             height: 25,
                           ),
                           SizedBox(
                             width: 300,
                             child: TextFormField(
                               controller: productname,
                               decoration: InputDecoration(
                                   labelText: "Enter Product Name",
                                   prefixIcon: Icon(Icons.mail_lock),
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
                             height: 20,
                           ),
                           SizedBox(
                             width: 300,
                             child: TextFormField(
                               controller: pprice,
                               decoration: InputDecoration(
                                   labelText: "Enter Product Price",
                                  prefixIcon: Icon(Icons.mail_lock),
                                   border: OutlineInputBorder(),
                                   focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(
                                           color: Colors.black, width: 1.0))),
                               validator: (pprice) {
                                 if (pprice!.isEmpty
                                     ) {
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
                            obscureText: true,
                               decoration: InputDecoration(
                                   labelText: "Enter Product Quantity ",
                                   prefixIcon: Icon(Icons.password_rounded),
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
                            Center(
                child: FutureBuilder<void>(
              future: retriveLostData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
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

            Center(
              child: ElevatedButton(onPressed: (){
                _pickImage();
              }, child: Text("pick image from gallery")),
            ),
                           
                          Card(
                               color: Colors.grey,
                               child: Padding(
                                padding: EdgeInsets.all(8.0),
                                 child: TextFormField(
                                     controller: productdescription,
                                     maxLines: 8, //or null
                                     decoration: InputDecoration.collapsed(
                                        hintText:
                                             "Add Product Description here !"),
                                     validator: (productdescription) {
                                       if (productdescription!.isEmpty) {
                                         return "Add Description";
                                       } else {
                                         print("Description\t"
                                             '$productdescription');
                                       }
                                     }),
                               )),
                           SizedBox(
                             height: 10,
                          ),
                          
                           SizedBox(
                             height: 30,
                           ),
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
               Center(child: Text("Follow Us")),
               Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.facebook),
                     Icon(Icons.apple),
                  ],
                 ),
               ),
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