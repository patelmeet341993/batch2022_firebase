import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main()async {

  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: InkWell(
         onTap: ()async{

           print("Click");
           try{

             GoogleSignInAccount? account=await GoogleSignIn().signIn();
             if(account==null)
               {
                 print("not login with any accpunt");
               }
             else
               {
                 print("login with google");

                 print("Name : ${account.displayName}");
                 print("Photo : ${account.photoUrl}");
                 print("Email : ${account.email}");

               }

           }
           catch(e)
           {
             print("Error : $e");
           }


         },
         child: Container(
           padding: EdgeInsets.all(10),
           color: Colors.grey,
           child: Text("Login"),
         ),
       ),
     ),
   );
  }
}
