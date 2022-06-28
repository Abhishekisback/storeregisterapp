import 'package:flutter/material.dart';
import 'package:storeregisterapp/dashboard.dart';
import 'package:storeregisterapp/forgotpassword.dart';
import 'package:storeregisterapp/service/http_service.dart';
import 'package:storeregisterapp/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: forgotpassword(),
    );
  }
}

class  forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class  _forgotpasswordState extends State<forgotpassword> {
  final formKey = GlobalKey<FormState>();
  String emailpattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  TextEditingController mailid = TextEditingController();
  TextEditingController Mobileno= TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  final double height = MediaQuery.of(context).size.height;
     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
     key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          title: Text("Forgot Password",style: TextStyle(color: Colors.white),),
          centerTitle: true,
            flexibleSpace: Image(
          image: AssetImage('lib/images/image2.jpeg'),
          fit: BoxFit.cover,),
        ),
      ),
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/images/image2.jpeg"),fit: BoxFit.cover),
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
                    " Forgot password ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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
                  padding:
                      EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all( color: Colors.white, width: 2),
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
                            child: TextFormField(
                              controller: mailid,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                  labelText: "Enter Mail ID",
                                  labelStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(Icons.mail_lock,color: Colors.white,),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
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
                              controller: Mobileno,
                             
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                              
                                  labelText: "Enter Your Mobile No ",
                                    labelStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(Icons.password_rounded ,color: Colors.white,),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0))),
                              validator: (lpassword) {
                                if (lpassword!.isEmpty) {
                                  return "Enter Mobile No";
                                } else {
                                  print("Mobile no\t" '$lpassword');
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
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: Colors.white70)),
                                ),
                                onPressed: () async{
                                 
                                   if (formKey.currentState!.validate()) {
                                   
                                     // loginUser(mailid.text, password.text);
                                    /* Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                               builder: (context) => dashboard(uname: mailid.text, umailid: password.text)),
                                          (route) => true);*/
                                   }
                                  //  if (mess() == "Logged in successfully") {
                                       /* Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => dashboard(uname: mailid.text, umailid: password.text)),
                                            (route) => true);*/

                                     /*   showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              title: Text(mess()),
                                              backgroundColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.all(40.0),
                                            );
                                          },
                                        );
                                      } */
                                     /* else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              title: Text(mess()),
                                              backgroundColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.all(40.0),
                                            );
                                          },
                                        );
                                        
                                      }*/
                                    
                                },
                                child: Text(
                                  "Get Password",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          SizedBox(height: 20,),
                          Center(child: Text("Your Password is",style: TextStyle(color: Colors.white),)),
                          SizedBox(
                            width: 300,
                            child: TextFormField(

                             
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                              
                                  labelText: "Your Password  ",
                                    labelStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(Icons.password_rounded ,color: Colors.white,),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0))),
                              
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                             new GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: new Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ), Spacer(),
                              new GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => signup()));
                                },
                                child: new Text(
                                  "Sign Up",
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
                     IconButton(onPressed: () {}, icon: Icon(Icons.facebook),),
                     IconButton(onPressed: () {}, icon: Icon(Icons.apple_sharp),),
                    
                    
                  ],
                ),
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
