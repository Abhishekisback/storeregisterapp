import 'dart:html';

import 'package:flutter/material.dart';
import 'package:storeregisterapp/product_json.dart';
import 'package:storeregisterapp/searchproduct.dart';

class editproducts extends StatefulWidget {
  final String prodid;
  const editproducts({Key? key,required this.prodid}) : super(key: key);

  @override
  State<editproducts> createState() => _editproductsState( prodid: prodid);
}

class _editproductsState extends State<editproducts> {
final String prodid;
  FetchUserList _userList = FetchUserList();
 _editproductsState ( {Key? key ,required this.prodid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("edit")),

body: Container(
      child: FutureBuilder<List<Userlist>>(
          future: _userList.getuserList(query: prodid),
          builder: (context, snapshot)
           {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Userlist>? data = snapshot.data;
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    
                    elevation: 6,
                    color: Color.fromRGBO(245, 245, 248, 1),
                    child: Column(

                      children:[ 
                        SizedBox(height: 30,),
                        SizedBox(
                                width: 300,
                                child: TextFormField(
                                  initialValue:'${data?[index].id}' ,
                                  //controller: usermailid,
                                  style: TextStyle(color: Colors.green),
                                  decoration: InputDecoration(
                                    //fillColor: Colors.green,
                                      labelText: "product name",
                                      labelStyle: TextStyle(color: Colors.black),
                                      prefixIcon: Icon(Icons.mail_lock,color: Colors.black,),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0))),
                                 
                                ),
                              ),
                              SizedBox(height: 30,),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  initialValue:'${data?[index].email}' ,
                                  //controller: usermailid,
                                  style: TextStyle(color: Colors.green),
                                  decoration: InputDecoration(
                                    //fillColor: Colors.green,
                                      labelText: "product name",
                                      labelStyle: TextStyle(color: Colors.black),
                                      prefixIcon: Icon(Icons.mail_lock,color: Colors.black,),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0))),
                                 
                                ),
                              ),
                              SizedBox(height: 30,),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  initialValue:'${data?[index].name}' ,
                                  //controller: usermailid,
                                  style: TextStyle(color: Colors.green),
                                  decoration: InputDecoration(
                                    //fillColor: Colors.green,
                                      labelText: "product quantity",
                                      labelStyle: TextStyle(color: Colors.black),
                                      prefixIcon: Icon(Icons.mail_lock,color: Colors.black,),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0))),
                                 
                                ),
                              ),
                            Row
                            (
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                SizedBox(width: 200,),
                                           Card( elevation:5,
                                           child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.edit), label: Text("edit and save "))),
                                             Spacer(),
                                             ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.delete),label: Text("delete "))
                                    ,SizedBox(width: 200,),
                              ],
                            ),


                      ],
                    ),
                  
                  );
                });
          }),
        )


    );
  }
}