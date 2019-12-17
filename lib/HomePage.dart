import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>snapshot;

  CollectionReference collectionReference=Firestore.instance.collection("TopPost");

  @override
  void initState() {
    // TODO: implement initState

    subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {
        snapshot=datasnapshot.documents;
      });
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Firebase Backend"),
        backgroundColor: Colors.purple,
        actions: <Widget>[

          IconButton(
              icon: Icon(Icons.search),
              onPressed: ()=>debugPrint("Search")),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: ()=>debugPrint("Add"))

        ],
      ),//AppBar

      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            UserAccountsDrawerHeader(
                accountName: Text("Lukas Tyas"),
                accountEmail: Text("tyas@gmail.com"),
            decoration: BoxDecoration(
              color: Colors.purple
            ),
            ),

            ListTile(
              title: Text("First Page"),
              leading: Icon(Icons.search,color: Colors.green,),
            ),
            ListTile(
              title: Text("Second Page"),
              leading: Icon(Icons.add,color: Colors.redAccent,),
            ),
            ListTile(
              title: Text("Third Page"),
              leading: Icon(Icons.cake,color: Colors.pink,),
            ),
            Divider(
              height: 10.0,
              color: Colors.black,
            ),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close,color: Colors.red,),
              onTap: (){
                Navigator.of(context).pop();
              },
            )

          ],
        ),
      ),//end drawer

      body: new ListView(
        children: <Widget>[

          new Container(
            height: 250,
            child: new ListView.builder(
                itemCount: snapshot.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 10.0,
                    child: Column(
                      children: <Widget>[

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(snapshot[index].data["url"],
                          height: 180.0,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(height: 10.0,),
                        Text(snapshot[index].data["title"])


                      ],
                    ),
                  );
                }
                ),
          )

        ],
      ),

    );
  }
}
