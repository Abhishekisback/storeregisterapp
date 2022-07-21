import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
String responseBody='';
String ipAddress = 'http://65.0.182.184';
String productresponseBody='';
String logresponseBody='';
String delresponseBody='';


dynamic storeid,productno;

registerUserStore(email,password,name,phone,storename,addressname,latitude,longitude) async {
  final uri = Uri.parse('$ipAddress/store/register');
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    'email': email,
    'password': password,
    'name': name,
    'addressname':addressname,
    'latitude':latitude,
    'longitude':longitude,
    'store_name':storename,
    'phone':phone,
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  responseBody = response.body;
  print(responseBody);

}

loginUser(email, password) async {
  final uri = Uri.parse('$ipAddress/store/login');
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {'email': email, 'password': password};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );
  print(response.body);
  int statusCode = response.statusCode;
  logresponseBody = response.body;

  //print(json.decode(logresponseBody)["message"]);
//  storeid=json.decode(logresponseBody)["store_user"]["store_id"];
 // print(storeid);
}





productbystore(store_id) async {
  final uri = Uri.parse('$ipAddress/productbystore');
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {'store_id': store_id};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );
  //print(response.body);
  int statusCode = response.statusCode;
  productresponseBody = response.body;
  print(productresponseBody);
  productno=json.decode(productresponseBody)["products"].length;

  //print(json.decode(responseBody)["products"]);
  //print(json.decode(productresponseBody));
  //storeid=json.decode(responseBody)["store_user"]["store_id"];
 // print(storeid);
}

// product search autocomplete
class ProductSearch {
  final String Pname;
  const ProductSearch({
    required this.Pname,
  });
  static ProductSearch fromJson(Map<String, dynamic> json) => ProductSearch(
        Pname: json['product_name'],
      );
}

class getProduct {
  static Future<List<ProductSearch>> getUserSuggestions(String query) async {
    final uri = Uri.parse('$ipAddress/productbystore');
    final response = await get(uri);

    if (response.statusCode == 200) {
      final List products = json.decode(response.body)["products"];
      print(products);

      return products
          .map((json) => ProductSearch.fromJson(json))
          .where((product) {
        final nameLower = product.Pname.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

delete_products(store_id, product_id) async {
  final uri = Uri.parse('$ipAddress/deleteproduct');
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {'store_id': store_id, 'product_id': product_id};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );
 
  int statusCode = response.statusCode;
  delresponseBody = response.body;
  print(delresponseBody);

  //print(json.decode(logresponseBody)["message"]);
//  storeid=json.decode(logresponseBody)["store_user"]["store_id"];
 // print(storeid);
}

/*product_update(store_id, product_id) async {
  final uri = Uri.parse('$ipAddress/deleteproduct');
  final headers = {'Content-Type': 'application/json'};
  
  Map<String, dynamic> body = {
  'product_id': product_id,
  'product_name': product_name,
  'product_description':product_description,
  'price':price,
  'quantity':quantity,
  'store_id':store_id,
  'category_name':category_name,
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );
 
  int statusCode = response.statusCode;
  delresponseBody = response.body;
  print(delresponseBody);

  //print(json.decode(logresponseBody)["message"]);
//  storeid=json.decode(logresponseBody)["store_user"]["store_id"];
 // print(storeid);
}*/

