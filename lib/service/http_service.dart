import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
String responseBody='';
dynamic storeid;

registerUserStore(email,password,name,phone,storename,addressname,latitude,longitude) async {
  final uri = Uri.parse('http://65.0.182.184/store/register');
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
  final uri = Uri.parse('http://65.0.182.184/store/login');
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
  responseBody = response.body;

  print(json.decode(responseBody)["message"]);
  storeid=json.decode(responseBody)["store_user"]["store_id"];
 // print(storeid);
}
mess()
{
  return  json.decode(responseBody)["message"];
}

getstoreid()
{
  return storeid;
}


