import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproj/collectiionlist/document_list_home.dart';
import 'package:firebaseproj/firestore_home.dart';
import 'package:firebaseproj/firestore_listen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLogin = false;
  String name = "", email = "", photo = "";

  Future<void> getLogOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      isLogin = false;
      setState(() {});
    } catch (e) {}
  }

  Future<void> checkLogin() async {
    isLogin = FirebaseAuth.instance.currentUser != null;

    if (FirebaseAuth.instance.currentUser == null) {
      print("no user found");
    } else {
      print("user found");

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        print(
            "email : ${user.email} :  ${user.displayName} : ${user.photoURL}");

        photo = user.photoURL!;
        email = user.email!;
        name = user.displayName!;
      }

     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Firestore_homepage()));

    }
  }

  Future<void> getLogin() async {
    try {
      GoogleSignInAccount? account = await GoogleSignIn().signIn();
      if (account == null) {
        print("not login with any accpunt");
      } else {
        print("login with google");

        print("Name : ${account.displayName}");
        print("Photo : ${account.photoUrl}");
        print("Email : ${account.email}");

        photo = account.photoUrl!;
        email = account.email;
        name = account.displayName!;

        GoogleSignInAuthentication auth = await account.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: auth.accessToken, idToken: auth.idToken);

        await FirebaseAuth.instance.signInWithCredential(credential);
        isLogin = true;
        setState(() {});
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DocumentListhome()));

      }
    } catch (e) {
      print("Error : $e");
    }
  }


  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !isLogin,
              child: InkWell(
                onTap: () async {
                  getLogin();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey,
                  child: Text("Login"),
                ),
              ),
            ),
            Visibility(
              visible: isLogin,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(photo),
                  Text("Name : $name"),
                  Text("email : $email"),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
