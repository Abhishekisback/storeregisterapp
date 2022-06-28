import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeregisterapp/addnewproducts.dart';
import 'package:storeregisterapp/main.dart';
import 'package:storeregisterapp/removeproducts.dart';

//import 'package:storekeeperapp/addnewproducts.dart';
//import 'package:storekeeperapp/main.dart';
//import 'package:storekeeperapp/recentupdates.dart';
//import 'package:storekeeperapp/removeproducts.dart';

class dashboard extends StatefulWidget {
  

   dashboard({Key? key}) : super(key: key);


  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  
_dashboardState( {Key? key });

  SharedPreferences ?logindata;
  String ?usermail;
  String ?userpassword;
  String ?storeidl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  } 
  void initial() async {
    logindata=await SharedPreferences.getInstance();
    setState(() {
      usermail=logindata!.getString('usermail');
      userpassword=logindata!.getString('userpassword');
      storeidl=logindata!.getString("store_id");
      print(storeidl);
    });
  }
 



  //SharedPreferences logindata;
  
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigoAccent.shade100,
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Welcome Store keeper",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            shadowColor: Color.fromARGB(255, 95, 94, 94),
            backgroundColor: Colors.indigoAccent.shade200),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: [
              Icon(
                Icons.verified_user_rounded,
                size: 70,
              ),
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(usermail.toString()),
                accountEmail: Text(userpassword.toString()),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.pink.shade50,
                  child: Text("Abhi"),
                ),
              ),
              ListTile(
                title:  Text(storeidl.toString()),
                onTap: () {},
              ),
              ListTile(
                title: Text(usermail.toString()),
                onTap: () {},
              ),
              ListTile(
                title: Text(userpassword.toString()),
                onTap: () {},
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                title: const Text("Log Out"),
                onTap: () {
                 logindata!.setBool('login', true);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                },
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(children: [
            /*   ElevatedButton.icon(
          onPressed: () async
          {
            Navigator.of(context).pop();



          },
          icon: Icon(Icons.arrow_back),
          label: Text(""),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 15),
          ),
        ),*/
            Removeproducts(context),
            Addnewproducts(context),
           
          ]),
        )),
      ),
    );
  }

  Widget Addnewproducts(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(300, 60),
          textStyle: TextStyle(fontSize: 15),
          primary: Color.fromARGB(225, 255, 252, 100),
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: Colors.white70))
        ),
        child: const Text("Add New Products"),
        onPressed: () {
          print(storeidl.toString());
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) =>MyImagePicker()));
        },
      ),
    );
  }

  Widget Removeproducts(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(300, 60),
          textStyle: TextStyle(fontSize: 15),
          primary:Color.fromARGB(225, 255, 252, 100),
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: Colors.white70))
        ),
        child: const Text("Remove Products"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => removeproducts(
                    usename: 'user_mail.toString()',
                    usermailid: 'user_password.toString()',
                  )));
        },
      ),
    );
  }
}
