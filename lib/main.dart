import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeregisterapp/dashboard.dart';
import 'package:storeregisterapp/forgotpassword.dart';
import 'package:storeregisterapp/service/http_service.dart';
import 'package:storeregisterapp/signup.dart';
import 'package:storeregisterapp/splash.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  String emailpattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  TextEditingController usermailid = TextEditingController();
  TextEditingController userpassword = TextEditingController();
  bool showSpinner = false;
  SharedPreferences? logindata;
  bool? newuser;
  bool? _loading;

  @override
  void initState() {
    // TODO: implement initState

    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata!.getBool('login') ?? true);
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
     
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          
          title: Text(
            "Join with us ,Integrate your business Online",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromARGB(255, 105, 171, 224),
        /*  flexibleSpace: Image(
            image: AssetImage('lib/images/image2.jpeg'),
            fit: BoxFit.cover,
          ),*/
          centerTitle: true,
        ),
      ),
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
           /* image: DecorationImage(
                image: AssetImage("lib/images/loginimage.jpeg"),
                fit: BoxFit.cover),*/
          ),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  child: Text(
                    "WELCOME TO ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  child: Text(
                    "NEW STORE REGISTRATION !!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 50, right: 50, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
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
                            height: 10,
                          ),
                          Center(
                              child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: usermailid,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  labelText: "Enter Mail ID",
                                  labelStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.mail_lock,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                enabledBorder:OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0))),
                              validator: (lmailid) {
                                if (lmailid!.isEmpty ||
                                    lmailid == null ||
                                    !RegExp(r'').hasMatch(lmailid)) {
                                  return "Please Enter  valid mail ID";
                                } else {
                                  print("Mail\t" '$lmailid');
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
                              controller: userpassword,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Enter Your Password ",
                                  labelStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.password_rounded,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0))),
                              validator: (lpassword) {
                                if (lpassword!.isEmpty) {
                                  return "Enter Password";
                                } else {
                                  print("Password\t" '$lpassword');
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlue,
                                  onPrimary: Colors.white,
                                  minimumSize: Size(300, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                      side:
                                          BorderSide(color: Colors.white70)),
                                ),
                                onPressed: () async {
                                   showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  );
                                  Future.delayed(Duration(seconds: 1), () async {
                                    //Navigator.of(context).pop();
                                   if (formKey.currentState!.validate()) {
                                    

                                    await loginUser(
                                        usermailid.text, userpassword.text);

                                    print(json.decode(logresponseBody));
                                    Navigator.of(context).pop();
                                    if (json.decode(
                                            logresponseBody)["message"] ==
                                        "Login Successful") {
                                      //print(getstoreid());
                                      logindata!.setBool('login', false);
                                      logindata!.setString(
                                          "usermail", usermailid.text);
                                      logindata!.setString(
                                          "userpassword", userpassword.text);
                                      logindata!.setString(
                                          "store_id",
                                          json
                                              .decode(logresponseBody)[
                                                  "store_user"]["store_id"]
                                              .toString());
                                      // logindata!.setString("store_id", value)

                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    dashboard(),
                                              ),
                                              (route) => false);
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>dashboard( uname: mailid.text,umailid: password.text,)));
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Welcome "),
                                            content: Text(
                                              json
                                                  .decode(logresponseBody)[
                                                      "store_user"]["email"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                          );
                                        },
                                      );
                                    } 
                                    else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(json.decode(
                                                logresponseBody)["message"]),
                                          );
                                        },
                                      );
                                     
                                    }
                                  }
                                  else{
                                     Navigator.of(context).pop();
                                  }
                                  });

                                  
                                  
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              new GestureDetector(
                                onTap: () {
                                       showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },
        );
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => signup()));
                                  });
                                },
                                child: new Text(
                                  "CreateAccount",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        /*  Center(
                            child: Container(
                              child: new GestureDetector(
                                onTap: () {
                              
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              forgotpassword()));
                                },
                                child: new Text(
                                  "Forgot your password",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              
              
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

