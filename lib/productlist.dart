

import 'package:flutter/material.dart';
import 'package:storeregisterapp/service/search_product_api.dart';
import 'package:storeregisterapp/viewproductdescription.dart';

import 'searchproduct.dart';
import 'product_json.dart';



/*
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: product_list_view_page(),
    );
  }
}*/
class  product_list_view_page extends StatefulWidget {
  
  @override
  _product_list_view_pageState createState() => _product_list_view_pageState();
}

class _product_list_view_pageState extends State<product_list_view_page> {
  
  FetchUserList _userList = FetchUserList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1f1545),
        appBar: AppBar(
          title: Text('Product List'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchUser());
              },
              icon: Icon(Icons.search_sharp),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<Userlist>>(
              future: _userList.getuserList(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                return Container( width: 500,
                  child: ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Card(
                           color: Colors.purple.shade600,
                             child: new InkWell(
                          onTap: () {
                          print("tapped");
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> viewproductdescription(prod_name:'${data?[index].name}')));
                          },

                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      
                                      child: Center(
                                        child: Text(
                                          '${data?[index].id}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                   
                                    SizedBox(width: 10),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data?[index].name}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '${data?[index].email}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ]),
                                        
                                  ],
                                ),
                                
                                // trailing: Text('More Info'),
                              ),
                            ),
                          ),
                             ),
                        );
                      }),
                );
              }),
        ),
      ),
    );
  }
}
