import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel{
  String name;
  String time;
  String url;
  DataModel({required this.name,required this.time,required this.url});
}