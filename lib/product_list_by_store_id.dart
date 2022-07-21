import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:flutter/material.dart';
import 'package:storeregisterapp/edit.dart';
import 'package:storeregisterapp/service/http_service.dart';
//import 'package:url_launcher/url_launcher.dart';

class CardPage extends StatefulWidget {
  CardPage(
   { Key? key, required this.storeid,
      })
      : super(key: key);

  String storeid;


  @override
  State<CardPage> createState() => _cardPageState();
}

class _cardPageState extends State<CardPage> {
  ScrollController listScrollController = ScrollController();
  late bool _isLoadingProduct;

  @override
  void initState() {
    // TODO: implement initState
    _isLoadingProduct = true;
    productbystore(widget.storeid.toString());

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoadingProduct = false;
      });
    });
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
       backgroundColor: Color(0xFF1f1545),
        appBar: AppBar(
          title: Text('Product List'),
          actions: [
        
              
          ],
        ),
      body: Container(
        color: Color(0xffF4F7FA),
        child: ListView(
          controller: listScrollController,
          children: <Widget>[
            
           /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16),
                 
                ),
              ],
            ),*/
            _isLoadingProduct
                ? Container(
                    height: 150,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _buildProductList()
          ],
        ),
      ),
    );
  }


  Widget _buildProductList() {
    var items = productItems();
    if (items.toString() != "[]") {
      return Column(
        children: [
          
          Container(
            height: 580,
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index) {
                var data = items[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 150,
                        height: 140,
                        alignment: Alignment.center,
                        child: Image.network(
                          data.image,
                          scale: 5,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 15,
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 130,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data.name,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 4),
                            width: 130,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Price: ₹" + data.price.toString(),
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                        primary: Colors.lightBlue,
                                        onPrimary: Colors.white,
                                        minimumSize: Size(50, 40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            side: BorderSide(color: Colors.white70)),
                                      ),
                            onPressed: (){
                              print("pressed");
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: ((context) => editproducts(
                                  categoryid: data.cat_id,
                                  storeid_:widget.storeid,
                                  productimage: data.image,
                                  prodid: data.prod_id,
                                  productname_: data.name,
                                  productquantity: data.quantity,
                                  productprice: data.price,
                                  productdescription: data.desc,
                                ) )));
                          }, 
                        
                          icon: Icon(Icons.edit),label: Text("Edit",style: TextStyle(fontSize: 20),)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Container(
        color: Colors.white,
        height: 350,
        alignment: Alignment.center,
        child: Text(
          "Products Not Available",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  List<Product> productItems() {
    var list = <Product>[];
    var data;
    int index = productno;
    print(index);

    if (index != 0) {
      for (int i = 0; i < index; i++) {
        data = Product(
            json.decode(productresponseBody)["products"][i]["_id"],
            json.decode(productresponseBody)["products"][i]["product_name"],
            json.decode(productresponseBody)["products"][i]["price"],
            json.decode(productresponseBody)["products"][i]["product_images"][0],
            json.decode(productresponseBody)["products"][i]["product_description"],
            json.decode(productresponseBody)["products"][i]["quantity"],
                json.decode(productresponseBody)["products"][i]["category_id"],
                );
        list.add(data);
      }
    }
    return list;
  }
}

class Product {
  String prod_id;
  String name;
  String price;
  String image;
  String desc;
  String quantity;
  String cat_id;

  Product(
    this.prod_id,
    this.name,
    this.price,
    this.image,
    this.desc,
    this.quantity,
    this.cat_id
  );
}