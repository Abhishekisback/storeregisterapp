//import 'dart:html';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:storeregisterapp/product_list_by_store_id.dart';
import 'package:storeregisterapp/service/http_service.dart';

class editproduct extends StatefulWidget {
  final String storeid_,
      prodid,
      
      categoryid,
      productimage;
  const editproduct(
      {Key? key,
      required this.storeid_,
      required this.prodid,
      required this.productimage,
      required this.categoryid,
     })
      : super(key: key);

  @override
  State<editproduct> createState() => _editproductState();
}

class _editproductState extends State<editproduct> {
  _editproductState({Key? key});
  TextEditingController productname=TextEditingController();
   TextEditingController productid=TextEditingController();
    TextEditingController productquantity=TextEditingController();
 TextEditingController productprice=TextEditingController();
  TextEditingController productdescription=TextEditingController();
  
  final String uploadUrl = 'http://65.0.182.184/productupdate';
final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  String? responsed;
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

  Future<String> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('product_images', filepath));
    print(productname);
    print(productdescription);
    print(productid);
    print(productprice);
    print(productquantity);
    request.fields['product_name'] = productname.text;
    request.fields['product_description'] =productdescription.text;
    request.fields['price'] =productprice.text;
    request.fields['quantity'] = productquantity.text;
    request.fields['product_id'] =widget.prodid ;
    request.fields['store_id'] = widget.storeid_;
    request.fields['category_id'] =widget.categoryid ;

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
            Text("New Image"),
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: Container(
                width: 200,
                height: 160,
                child: Image.file(File(_imageFile!.path)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      );
    } else {
      return Container();
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
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  width: 300,
                  height: 200,
                  child: Image.network(
                    widget.productimage,
                    scale: 5,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      print("change image  pressed");
                      _pickImage();
                    },
                    child: Text("Change Image")),
                Center(
                    child: FutureBuilder<void>(
                  future: retriveLostData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
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
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    readOnly: true,
                    //controller: usermailid,

                    style: TextStyle(color: Colors.green),
                    initialValue: widget.prodid,
                    decoration: const InputDecoration(

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
                    readOnly: true,
                    //controller: usermailid,

                    style: TextStyle(color: Colors.green),
                    initialValue: widget.categoryid,
                    decoration: const InputDecoration(

                        //fillColor: Colors.green,

                        labelText: "category_id",
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
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: productname,

                    //controller: usermailid,

                    style: const TextStyle(color: Colors.green),

                    decoration: const InputDecoration(

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
                                    validator: (lpassword) {
                                if (lpassword!.isEmpty) {
                                  return "Enter Password";
                                } else {
                                  print("Password\t" '$lpassword');
                                }
                              },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                 controller: productquantity,

                    //controller: usermailid,

                    style: const TextStyle(color: Colors.green),

                    decoration: const InputDecoration(

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
                                    validator: (lpassword) {
                                if (lpassword!.isEmpty) {
                                  return "Enter Password";
                                } else {
                                  print("Password\t" '$lpassword');
                                }
                              },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: productprice,

                    //controller: usermailid,

                    style: const TextStyle(color: Colors.green),

                    decoration: const InputDecoration(

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
                                    validator: (lpassword) {
                                if (lpassword!.isEmpty) {
                                  return "Enter Password";
                                } else {
                                  print("Password\t" '$lpassword');
                                }
                              },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: productdescription,
                              maxLines: 8, //or null

                              decoration: const InputDecoration.collapsed(
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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    "Do You Want to Update the changes made ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                      //  print(_imageFile!.path);
                                     
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.green),
                                              strokeWidth: 5,
                                            ));
                                          },
                                        );
                                        if (_imageFile != null) {
                                          
                                          
                                            Navigator.pop(context);
                                            Navigator.of(context).pop();
                                         
                                          var res = await uploadImage(
                                              _imageFile!.path, uploadUrl);
                                          print(res);
                                          if(res=="OK"){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Server Response"),
                                                content: Text("Product Details Updated Successfully"),
                                              );
                                            },
                                          );
                                          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => CardPage(storeid: widget.storeid_))));
                                          }
                                          else{
                                             showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Server Response"),
                                                content: Text("Error in Updating!!!"),
                                              );
                                            },
                                          );

                                          }
                                        }
                                      }
                            ,
                                      child: const Text("Yes",
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
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        await delete_products(
                                            widget.storeid_, widget.prodid);
                                        //Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(json.decode(
                                                  delresponseBody)["message"]),
                                            );
                                          },
                                        );
                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      CardPage(
                                                          storeid: widget
                                                              .storeid_))));
                                        });
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
