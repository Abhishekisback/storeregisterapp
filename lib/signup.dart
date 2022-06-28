import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:storeregisterapp/service/http_service.dart';

class signup extends StatefulWidget {
  const signup({
    Key? key,
  }) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool imageAvailable = false;
  //late Uint8List imagefile;

  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController store_name = TextEditingController();
  TextEditingController storeaddress = TextEditingController();

  double? lat;

  double? long;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  //
  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      print("value $value");
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      // getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      print("Error $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text( "New Registration",style: TextStyle(color: Colors.blue , fontWeight: FontWeight.bold),),
          centerTitle: true,
          flexibleSpace: Image(
          image: AssetImage('lib/images/image2.jpeg'),
          fit: BoxFit.cover,),
          
        ),
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
                Container(
                  child: Text(
                    "WELCOME ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "STORE REGISTRATION ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold

                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      Spacer(),
                      new GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: new Text(
                          "Already have an Account! Sign In",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  "PLEASE FILL REQUIIRED DETAILS",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 50, right: 50, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all( color: Colors.white,width: 2),
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
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: name,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: "Enter Full Name",
                                     labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: Icon(
                                        Icons.supervised_user_circle_outlined,color: Colors.white,),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0))),
                                validator: (name) {
                                  if (name!.isEmpty) {
                                    return "Please Enter your Name";
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: email,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: "Enter Your E-mail Id ",
                                     labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: Icon(Icons.email_outlined, color: Colors.white,),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0))),
                                validator: (mailid) {
                                  if (mailid!.isEmpty) {
                                    return "Enter email";
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: password,
                                
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: "Create Your Password ",
                                     labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: Icon(Icons.lock,color: Colors.white,),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0))),
                                validator: (password) {
                                  if (password!.isEmpty) {
                                    return "Please Enter Password";
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
                                controller: phone,
                                style: TextStyle(color: Colors.white),
                                
                                decoration: InputDecoration(
                                    labelText: "Mobile No ",
                                     labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon: Icon(Icons.phone_android , color: Colors.white,),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0))),
                                validator: (Mobile) {
                                  if (Mobile!.isEmpty) {
                                    return "Please Enter your Mobile No";
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
                                controller: store_name,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: " Enter the store Name",
                                     labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon:
                                        Icon(Icons.store_mall_directory_sharp,color: Colors.white,),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0))),
                                validator: (storename) {
                                  if (storename!.isEmpty) {
                                    return "Enter Store name";
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
                                controller: storeaddress,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    labelText: " Enter the Store Address",
                                     labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon:
                                        Icon(Icons.store_mall_directory_sharp,color: Colors.white,),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0))),
                                validator: (storename) {
                                  if (storename!.isEmpty) {
                                    return "Enter Store Address";
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.amber.shade300,
                                    onPrimary: Colors.grey.shade600,
                                    elevation: 20,
                                    minimumSize: Size(100, 50),
                                    
                                    shadowColor:
                                        Colors.amber.shade300,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    getLatLong();
                                    
                                  },
                                  child: Text(
                                    "Get live store location ",
                                  
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                           /* ElevatedButton.icon(
  onPressed: () {},
  icon: Icon( // <-- Icon
    Icons.download,
    size: 24.0,
  ),
  label: Text('Download'), // <-- Text
),*/
                            SizedBox(
                              height: 15,
                            ),
                            Center(child: Container( padding: EdgeInsets.all(10), decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5.0),
                    ), child: Text("latitude : $lat", textScaleFactor: 1.2, style: const TextStyle(fontSize: 15,color: Colors.white),))),
                            SizedBox(
                              height: 15,
                            ),
                                  Center(child: Container( padding: EdgeInsets.all(10), decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5.0),
                    ), child: Text("longitude : $long", textScaleFactor: 1.2, style: const TextStyle(fontSize:15 ,color: Colors.white),))),

                            


                                    
                                    SizedBox(
                              height: 15,
                            ),
                            
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.amber.shade300,
                                    onPrimary: Colors.grey.shade600,
                                    elevation: 20,
                                    minimumSize: Size(200, 50),
                                    shadowColor:
                                        Colors.amber.shade600,
                                        shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: Colors.white70)),
                                        
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      await registerUserStore(email.text,password.text,name.text,phone.text,store_name.text,storeaddress.text,lat,long);
                                      print(mess());
                                       if (mess().toString() =="User Already exists,Please go for login") 
                                      {
                                            
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
                                       
                                       
                                      }
                                      else {
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

                                      }
                                      print(email.text);
                                      print(password.text);
                                      print(name.text);
                                      print(storeaddress.text);
                                      print(lat);
                                      print(long);
                                      print(store_name.text);
                                      print(phone.text);
                                    }
                                    /* if (formKey.currentState!.validate()) {
                                       await registerStore(
                                          email.text,
                                          password.text,
                                          name.text,
                                          address.text,
                                          phone.text,
                                          store_name.text);
                                      if (mess().toString() =="User registered Successfully!") 
                                      {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (route) => true);
                                             Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              title: Text(''),
                                              backgroundColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.all(40.0),
                                            );
                                          },
                                        );
                                        print("user registered ");
                                          Navigator.pop(context);
                                       
                                      }
                                      else { 
                                              Navigator.of(context).pop();

                                   showDialog(
                                    
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              title: Text(''),
                                              backgroundColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.all(40.0),
                                            );
                                          },
                                        );


                                      }
                                    }*/
                                  },
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
