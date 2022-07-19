import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeregisterapp/addnewproducts.dart';
import 'package:storeregisterapp/edit.dart';
import 'package:storeregisterapp/main.dart';
import 'package:storeregisterapp/product_list_by_store_id.dart';

//import 'package:storekeeperapp/addnewproducts.dart';
//import 'package:storekeeperapp/main.dart';
//import 'package:storekeeperapp/recentupdates.dart';
//import 'package:storekeeperapp/removeproducts.dart';

class dashboard extends StatefulWidget {
  dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  SharedPreferences? logindata;
  String? usermail;
  String? userpassword;
  String? storeidl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      usermail = logindata!.getString('usermail');
      userpassword = logindata!.getString('userpassword');
      storeidl = logindata!.getString("store_id");
      print(storeidl);
      //productbystore(storeidl);
    });
  }
 _circularloadingbar(BuildContext context)
  {
 showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
            },
          );
  }

  //SharedPreferences logindata;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Welcome Store keeper",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
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
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.pink.shade50,
                  child: Text(usermail.toString().substring(0, 4)),
                ),
              ),
              ListTile(
                title: Text(storeidl.toString()),
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
               
                   
                  /* Future.delayed(const Duration(seconds: 4 ), () {

// Here you can write your code



});*/

                 
                    logindata!.setBool('login', true);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Logut"),
                          content: Text("Are you Sure You want to logout ???"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  _circularloadingbar(context);
                                  Future.delayed(Duration(seconds: 3), () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  });
                                },
                                child: Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  _circularloadingbar(context);
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text("No")),
                          ],
                        );
                      });
                },
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                // Removeproducts(context),
                SizedBox(
                  height: 60,
                ),
                Addnewproducts(context),

                viewproducts(context),
              ]),
        )),
      ),
    );
  }

  Widget Addnewproducts(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 60),
            textStyle: TextStyle(fontSize: 15),
            primary: Colors.lightBlue,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.white70))),
        child: const Text("Add New Products"),
        onPressed: () {
          _circularloadingbar(context);
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            print(storeidl.toString());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => addnewprod(
                      userstoreid: storeidl.toString(),
                      email_user: usermail.toString(),
                      pass_word: userpassword.toString(),
                    )));
          });
        },
      ),
    );
  }

  Widget viewproducts(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 60),
            textStyle: TextStyle(fontSize: 15),
            primary: Colors.lightBlue,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.white70))),
        child: const Text("view products"),
        onPressed: () {
          _circularloadingbar(context);
          Future.delayed( Duration(milliseconds: 500), () {

// Here you can write your code
 Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => CardPage(storeid: storeidl.toString()))));
  

});
         
        },
      ),
    );
  }
}
