
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproj/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firestore_homepage extends StatefulWidget {
  const Firestore_homepage({Key? key}) : super(key: key);

  @override
  _Firestore_homepageState createState() => _Firestore_homepageState();
}

class _Firestore_homepageState extends State<Firestore_homepage> {


  Future<void> getLogOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      setState(() {});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

    } catch (e) {}
  }


  void pushData()async{


    Map<String,dynamic> myd=HashMap();

    myd["name"]="meet12allll3";
    myd["degree"]="csae";
    myd["year of passing"]=20214;

    await FirebaseFirestore.instance.collection("mycollecion").doc("fixname").set(myd);
    print("added");

  }

  void getData()async{
    User? user = FirebaseAuth.instance.currentUser;
   DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection("user").doc(user!.uid).get();

  Map<dynamic,dynamic> data=snapshot.data() as Map;

    print("data :  $data");


    print("img :  ${data["img"]}");


  }

  void pushUserData()async{

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {

      Map<String,dynamic> data=HashMap();
      data["email"]=user.email!;
      data["name"]=user.displayName!;
      data["img"]=user.photoURL!;
      await FirebaseFirestore.instance.collection("user").doc(user.uid).set(data);
      print("added");
    }

  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              InkWell(
                onTap: () async {
                  getLogOut();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  child: Text("Log Out"),
                ),
              ),

              SizedBox(height: 30,),

              InkWell(
                onTap: () async {
                  pushData();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  child: Text("Push Data"),
                ),
              ),


              SizedBox(height: 30,),

              InkWell(
                onTap: () async {
                  pushUserData();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  child: Text("Push user data"),
                ),
              ),

              SizedBox(height: 30,),

              InkWell(
                onTap: () async {
                  getData();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  child: Text("Get User data"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
