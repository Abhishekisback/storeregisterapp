import 'package:flutter/material.dart';
import 'package:storeregisterapp/editproductpage.dart';
import 'package:storeregisterapp/searchproduct.dart';
import 'product_json.dart';

 class viewproductdescription extends StatefulWidget {
  final String prod_name;
  const viewproductdescription({Key? key,required this.prod_name}) : super(key: key);

  @override
  State<viewproductdescription> createState() => _viewproductdescriptionState( produ_name: prod_name);
}

class _viewproductdescriptionState extends State<viewproductdescription> {
  String produ_name;
   FetchUserList _userList = FetchUserList();
  _viewproductdescriptionState( {Key? key ,required this.produ_name});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold( 
      appBar: AppBar(actions: [
        
        /*IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back ,),)*/
      ]),
      body: Container(
      child: FutureBuilder<List<Userlist>>(
          future: _userList.getuserList(query: produ_name),
          builder: (context, snapshot)
           {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Userlist>? data = snapshot.data;
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    
                    elevation: 6,
                    color: Color.fromRGBO(245, 245, 248, 1),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '${data?[index].id}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                      
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //${data?[index].name}
                                height: 50,
                                width: 50,
                               
                  
                                child: Text('${data?[index].name}'),
                                
                              ),
                              
                                Text(
                                '${data?[index].address}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                                Text(
                                '${data?[index].username}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${data?[index].email}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]),
      
                            Spacer(),
                            ElevatedButton.icon(onPressed: () { print("edit button tapped");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>editproducts( prodid: produ_name,) ));
                            }, icon:Icon(Icons.edit), label: Text("edit"))
      
                      ],
                    ),
                  );
                });
          }),
        ),);
    

    
  }
}