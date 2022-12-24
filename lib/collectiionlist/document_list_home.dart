import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseproj/collectiionlist/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class DocumentListhome extends StatefulWidget {
  const DocumentListhome({Key? key}) : super(key: key);

  @override
  _DocumentListhomeState createState() => _DocumentListhomeState();
}

class _DocumentListhomeState extends State<DocumentListhome> {
  late TextEditingController controller;

  XFile? file;
  List<DataModel> list = [];

  bool isLoading=false;

  List<String> urls = [
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/MS_Dhoni_in_2011.jpeg?alt=media&token=23471376-4add-4d9c-be7a-a26713f625a6",
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/dhoni.jpeg?alt=media&token=58acc8f9-fa83-4f36-8fa6-7e3aa83d5576",
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/img_192351_viratkohli.jpeg?alt=media&token=856b098d-db6f-4575-a9eb-ae9a21259334",
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/MS_Dhoni_in_2011.jpeg?alt=media&token=23471376-4add-4d9c-be7a-a26713f625a6",
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/dhoni.jpeg?alt=media&token=58acc8f9-fa83-4f36-8fa6-7e3aa83d5576",
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/img_192351_viratkohli.jpeg?alt=media&token=856b098d-db6f-4575-a9eb-ae9a21259334",
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/MS_Dhoni_in_2011.jpeg?alt=media&token=23471376-4add-4d9c-be7a-a26713f625a6",
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/dhoni.jpeg?alt=media&token=58acc8f9-fa83-4f36-8fa6-7e3aa83d5576",
    "https://firebasestorage.googleapis.com/v0/b/batch2022-52af2.appspot.com/o/img_192351_viratkohli.jpeg?alt=media&token=856b098d-db6f-4575-a9eb-ae9a21259334",
  ];

  Random r = Random();

  void getData() {
    FirebaseFirestore.instance.collection("mydata").get().then((value) {
      list.clear();
      for (int i = 0; i < value.docs.length; i++) {
        Map<String, dynamic> map = value.docs[i].data();
        DataModel model = DataModel(
            name: map["name"], time: map["time"].toString(), url: map["img"]);
        list.add(model);
      }
      setState(() {});
    });
  }

  void startListining() {
    FirebaseFirestore.instance.collection("mydata").snapshots().listen((value) {
      list.clear();
      for (int i = 0; i < value.docs.length; i++) {
        Map<String, dynamic> map = value.docs[i].data();
        DataModel model = DataModel(
            name: map["name"], time: map["time"].toString(), url: map["img"]);
        list.add(model);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    startListining();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller,
                        onChanged: (txt){

                          Map<String, dynamic> data = HashMap();

                          data["time"] = "";
                          data["img"] = urls[0];


                          if(txt.isEmpty)
                            {
                              data["name"] = "";
                            }
                          else{
                            data["name"] = "typing....";
                          }

                          FirebaseFirestore.instance
                              .collection("mydata")
                              .doc("type")
                              .set(data);

                        },
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: file==null,
                    child: InkWell(
                      onTap: ()async {
                        file = await ImagePicker().pickImage(source: ImageSource.gallery);
                        setState(() {

                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.blueAccent,
                        child: Text(
                          "Select profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: file!=null && !isLoading,
                    child: InkWell(
                      onTap: ()async {



                        try
                        {

                          isLoading=true;
                          setState(() {

                          });

                          Reference ref = FirebaseStorage.instance
                              .ref()
                              .child('images')
                              .child(file!.name);

                          TaskSnapshot task=await ref.putFile(io.File(file!.path));
                         String url = await task.ref.getDownloadURL();



                          String name = controller.text;

                          Map<String, dynamic> data = HashMap();
                          data["name"] = name;
                          data["time"] = FieldValue.serverTimestamp();
                          data["img"] = url;

                              FirebaseFirestore.instance
                                  .collection("mydata")
                                  .doc()
                                  .set(data);

                          controller.text = "";
                          file=null;
                          isLoading=false;
                          setState(() {

                          });

                        }
                        catch(e)
                        {
                          print("error : $e");
                        }




                        // getData();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.blueAccent,
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                      visible: isLoading,
                      child: SpinKitRing(color: Colors.blueAccent,))

                  // InkWell(
                  //   onTap: () {
                  //     getData();
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(10),
                  //     color: Colors.blueAccent,
                  //     child: Text(
                  //       "Get Data",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (ctx, index) {
                      return listViewItem(list[index]);
                    }))
          ],
        ),
      ),
    ));
  }

  Widget listViewItem(DataModel model) {
    return Container(
      color: Colors.grey.shade200,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                model.url,
                height: 50,
                width: 50,
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name),
                Text(model.time),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
