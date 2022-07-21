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
     {
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
    
    splash: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
              Image.asset('lib/images/Capture12.png',scale: 3,),
    
          LinearProgressIndicator(
           // value:4,
            minHeight: 10,
             backgroundColor: Colors.cyanAccent,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
    
    
            ),
        ],
      ),
    ),
    nextScreen: Home(),
    duration: 3500,
    splashTransition: SplashTransition.slideTransition,
    splashIconSize: 150,
  );
}
