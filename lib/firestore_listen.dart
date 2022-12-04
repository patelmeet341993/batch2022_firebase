import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreListen extends StatefulWidget {
  const FireStoreListen({Key? key}) : super(key: key);

  @override
  _FireStoreListenState createState() => _FireStoreListenState();
}

class _FireStoreListenState extends State<FireStoreListen> {

  String data="No data";

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            InkWell(
              onTap: (){
                //
                 FirebaseFirestore.instance.collection("data").doc("my123").snapshots().listen((snapshot) {
                   Map<dynamic,dynamic> map=snapshot.data() as Map;
                   data=map.toString();
                   setState(() {});
                 });

                 
              },
              child: Container(
                color: Colors.blueAccent,
                padding: EdgeInsets.all(15),
                child: Text("Start Listening",style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ),
            Expanded(child: Text(data)),

          ],

        ),
      ),
    );
  }
}
