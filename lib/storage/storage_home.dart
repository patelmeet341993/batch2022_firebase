import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class StorageHome extends StatefulWidget {
  const StorageHome({Key? key}) : super(key: key);

  @override
  _StorageHomeState createState() => _StorageHomeState();
}

class _StorageHomeState extends State<StorageHome> {

  XFile? file;
  String url="";


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            InkWell(
              onTap: ()async{
                 file = await ImagePicker().pickImage(source: ImageSource.gallery);
                 setState(() {

                 });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white60,
                child: Text("Select File"),
              ),
            ),
            Visibility(
              visible: file!=null,
              child: InkWell(
                onTap: ()async{

                  try
                  {

                    Reference ref = FirebaseStorage.instance
                        .ref()
                        .child('images')
                        .child('/my.jpg');

                    TaskSnapshot task=await ref.putFile(io.File(file!.path));
                    url = await task.ref.getDownloadURL();
                    setState(() {

                    });


                  }
                  catch(e)
                  {
                    print("error : $e");
                  }

                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white60,
                  child: Text("Upload File"),
                ),
              ),
            ),
            Image.network(url,height: 200,width: 200,)
          ],
        ),
      ),
    );
  }
}
