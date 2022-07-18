//import 'dart:html';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeregisterapp/addnewproducts.dart';

class editproducts extends StatefulWidget {
  final String storeid_,
      catid,
      productname_,
      productprice,
      productdescription,
      productquantity,
      productimage;
  const editproducts(
      {Key? key,
      required this.storeid_,
      required this.catid,
      required this.productimage,
      required this.productdescription,
      required this.productname_,
      required this.productprice,
      required this.productquantity})
      : super(key: key);

  @override
  State<editproducts> createState() => _editproductsState();
}

class _editproductsState extends State<editproducts> {
  _editproductsState({Key? key});

  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
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
        appBar: AppBar(title: Text("Edit")),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                InkWell(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: 300,
                      height: 200,
                      child: Image.network(
                        widget.productimage,
                        scale: 5,
                      ),
                    ),
                    onTap: () {

                         print("network image  pressed");
                    //  _pickImage();
                  
                     showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog
                        (
                           title: Text("Server Response"),
                           content: Text("Product Added Successfully"),

                        );
                      },
                    );
                           
                    }
                    
                    ),
                SizedBox(
                  height: 30,
                ),
                
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    readOnly: true,
                    //controller: usermailid,

                    style: TextStyle(color: Colors.green),
                    initialValue: widget.catid,
                    decoration: InputDecoration(

                        //fillColor: Colors.green,

                        labelText: "Product Id",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.card_travel_rounded,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: widget.productname_,

                    //controller: usermailid,

                    style: TextStyle(color: Colors.green),

                    decoration: InputDecoration(

                        //fillColor: Colors.green,

                        labelText: "product name",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.supervised_user_circle_sharp,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: widget.productquantity,

                    //controller: usermailid,

                    style: TextStyle(color: Colors.green),

                    decoration: InputDecoration(

                        //fillColor: Colors.green,

                        labelText: "product quantity",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.production_quantity_limits_sharp,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: widget.productprice,

                    //controller: usermailid,

                    style: TextStyle(color: Colors.green),

                    decoration: InputDecoration(

                        //fillColor: Colors.green,

                        labelText: "product price",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.price_check,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              initialValue: widget.productdescription,
                              maxLines: 8, //or null

                              decoration: InputDecoration.collapsed(
                                  hintText: "Add Product Description here !",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  )),
                              validator: (productdescription) {
                                if (productdescription!.isEmpty) {
                                  return "Add Description";
                                } else {
                                  print("Description\t"
                                      '$productdescription');
                                }
                              }),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    "Do You Want to Update the changes made ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Yes",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.green))),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit),
                        label: Text("edit and save ")),
                    Spacer(),
                    ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Do You Want to Delete ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Yes",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.green))),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                        label: Text("delete ")),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
