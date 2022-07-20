import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeregisterapp/main.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen>
    with TickerProviderStateMixin {
  @override
 
  SharedPreferences? logindata;
  bool? newuser;
  Widget build(BuildContext context) {
    return Scaffold(
      body: _splashfunction(context),
    );

    /*body: Column
     (
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: 
      [
        
        
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: Image.asset('lib/images/image2.jpeg')),
          ),

          
    
    
    
      ],
     ),
    );*/
  }
}

_splashfunction(context) {
  return AnimatedSplashScreen(
    splash: Column(
      children: [
        Container(
            height: 100,
            width: 100,
            child: Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
            )),
        LinearProgressIndicator(
         // value:4,
          minHeight: 10,
           backgroundColor: Colors.cyanAccent,
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),


          ),
      ],
    ),
    nextScreen: Home(),
    duration: 3500,
    splashTransition: SplashTransition.rotationTransition,
    splashIconSize: 150,
  );
}
