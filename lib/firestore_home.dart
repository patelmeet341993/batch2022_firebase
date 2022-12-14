
import 'dart:collection';
import 'dart:math';

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

  void pushData1()async{

    Random r=Random();

    Map<String,dynamic> maindata=HashMap();

    maindata["name"]="xyz";
    maindata["age"]=r.nextInt(100);
    maindata["dob"]="22-dec-2000";
    maindata["blood"]="O+ve";

    Map<dynamic,dynamic> edudata=HashMap();

    edudata["clg"]="Parul";
    edudata["branch"]="cse";
    edudata["roll"]=r.nextInt(100);
    edudata["sem"]=r.nextInt(8);

    Map<dynamic,dynamic> famdata=HashMap();

    famdata["Father"]="abc";
    famdata["Mother"]="xyz";
    famdata["Brother"]="aaa";
    famdata["Sister"]="bbb";

    maindata["familydata"]=famdata;
    maindata["edudata"]=edudata;


    await FirebaseFirestore.instance.collection("students").doc().set(maindata);
    print("student added");

  }

  void pushData2()async{

    Random r=Random();

    Map<String,dynamic> maindata=HashMap();

    maindata["name"]="xyz";
    maindata["age"]=r.nextInt(100);
    maindata["dob"]="22-dec-2000";
    maindata["blood"]="O+ve";



    Map<dynamic,dynamic> edudata=HashMap();




    Map<dynamic,dynamic> school=HashMap();

    school["name"]="abc";
    school["passing year"]=2010;


    Map<dynamic,dynamic> clg=HashMap();

    clg["name"]="xyz";
    clg["sem"]=7;


    Map<dynamic,dynamic> famdata=HashMap();

    famdata["Father"]="abc";
    famdata["Mother"]="xyz";
    famdata["Brother"]="aaa";
    famdata["Sister"]="bbb";

    List<String> sports=["cricket","abc","xxys","sadas"];
    sports.add("lll");



    maindata["familydata"]=famdata;
      maindata["edudata"]=edudata;
    edudata["school"]=school;
    edudata["clg"]=clg;

    school["sports"]=sports;

    maindata["array"]=sports;
    maindata["isStudyRunning"]=r.nextBool();

    maindata["createdTime"]=FieldValue.serverTimestamp();


    Map<dynamic,dynamic> msg1=HashMap();
    msg1["name"]="abc";
    msg1["time"]="abc";//FieldValue.serverTimestamp();
    msg1["msg"]="hi";

    Map<dynamic,dynamic> msg2=HashMap();
    msg2["name"]="xyz";
    msg2["time"]="abc";//FieldValue.serverTimestamp();
    msg2["msg"]="hello";

    Map<dynamic,dynamic> msg3=HashMap();
    msg3["name"]="xyz";
    msg3["time"]="abc";//FieldValue.serverTimestamp();
    msg3["msg"]="asdasdas";

    List<dynamic> msgs=[];
    msgs.add(msg1);
    msgs.add(msg2);
    msgs.add(msg3);

    maindata["msgs"]=msgs;


    await FirebaseFirestore.instance.collection("students2").doc().set(maindata);
    print("student added");

  }

  void updateTimeStamp()async{

    Map<String,dynamic> data=HashMap();
    data["lastUpdated"]=FieldValue.serverTimestamp();
    await FirebaseFirestore.instance.collection("students2").doc("So35Hdez7rMOpei4JiKv").update(data);

    print("updated");
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

              SizedBox(height: 30,),

              InkWell(
                onTap: () async {
                  pushData1();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  child: Text("Push Data 1"),
                ),
              ),
              SizedBox(height: 30,),

              InkWell(
                onTap: () async {
                  pushData2();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  child: Text("Push Data 2"),
                ),
              ),
              SizedBox(height: 30,),

              InkWell(
                onTap: () async {
                  updateTimeStamp();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  child: Text("update timestamp"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
