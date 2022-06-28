import 'package:flutter/material.dart';
import 'package:storeregisterapp/productlist.dart';
//import 'package:storekeeperapp/productlist.dart';

class removeproducts extends StatefulWidget {
  final String usename,usermailid;
  const removeproducts({Key? key,required this.usename,required this.usermailid}) : super(key: key);

  @override
  State<removeproducts> createState() => _removeproductsState( userna: usename,usermail: usermailid);
}

class _removeproductsState extends State<removeproducts> {
  String userna,usermail;
  _removeproductsState( {Key? key ,required this.userna,required this.usermail});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
         return Scaffold
    (
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          title: Text("Remove Products"),
          leadingWidth: 70,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              accountName: Text(userna),
              accountEmail: Text(usermail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.pink.shade50,
                child: Text("AB"),
              ),
            ),
            ListTile(
              title: Text("Recent Updates", textDirection: TextDirection.ltr),
              leading: Icon(Icons.update),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>product_list_view_page()));
              },
            ),
            ListTile(
              title: Text("Store Info", textDirection: TextDirection.ltr),
              leading: Icon(Icons.more),
              onTap: () {},
            ),
            ListTile(
              title: Text("User Details", textDirection: TextDirection.ltr),
              leading: Icon(Icons.supervised_user_circle_sharp),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout", textDirection: TextDirection.ltr),
              leading: Icon(Icons.logout_sharp),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: 
      SingleChildScrollView(
     child: Column(
        children: [
          
      
            Center(
              child: Container
          (
              height: 1200,
              width: 1200,
              decoration:const BoxDecoration(
                image: DecorationImage(image: NetworkImage("https://m.media-amazon.com/images/I/61lOFfJj4yL._SX522_.jpg"),fit: BoxFit.cover)),
              ),
            ),
        ],
      ),
      ),
      );
     



    
  }
}