import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/global.dart';
import 'package:task_app/model/usermodel.dart';
import 'package:task_app/send.dart';

import '../main_navigation/navigation.dart';

class Login extends StatefulWidget {
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email=TextEditingController();

  TextEditingController password=TextEditingController();

  bool signup=false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Global.globalwhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          s(160),
          Center(child: Image.asset("assets/logo (4).png",width: 90,)),
          s(12),
          Center(child: Text("Let's get Started ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 23),)),
          s(16),
          Global.text("     Type your Email"),
          s(7),
          Global.textFieldEditor(controller: email),
          s(10),
          Global.text("     Type your Password"),
          s(7),
          Global.textFieldEditor(controller: password),
          s(18),
          Center(
            child: InkWell(
              onTap: () async {
                try{
                if(email.text.isEmpty||password.text.isEmpty){
                  return ;
                }
                if(signup){
                  final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email.text, password: password.text);
                  final String id = cred.user!.uid;
                  UserModel user= UserModel(name: "", id:id , pic: "", task: []);
                  await FirebaseFirestore.instance.collection("Users").doc(id).set(user.toJson());
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => MyHomePage(title: '',)));
                  Send.showMessage(context, "SignUp Successful", true);
                }else{
                  final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text, password: password.text);
                  final String id = cred.user!.uid;
                  await checkAndCreateUser(id);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => MyHomePage(title: '',)));
                  Send.showMessage(context, "SignIn Successful", true);
                }
                }catch(e){
                  Send.showMessage(context, "${e}", false);
                }
              },
              child: Container(
                width: w*5/8,
                decoration: BoxDecoration(
                  color: Global.globalcolor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19,vertical: 15),
                  child: Center(child: Text(signup?"SIGN UP":"LOGIN",style: TextStyle(color: Colors.white,fontSize: 19),)),
                )
              ),
            ),
          ),
          s( 29,),
          Center(child: Text(signup?"or SignUp with Social Login":"or Login with Social Login",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.grey),)),
          s(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              s(1),
              ci("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQazseuQBxxvSQ8M8eGA67yPzsozd9MfoyiEw&s"),
              ci("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Google_Plus_icon_%282015-2019%29.svg/1200px-Google_Plus_icon_%282015-2019%29.svg.png"),
              ci("https://www.shutterstock.com/shutterstock/videos/1079349806/thumb/1.jpg?ip=x480"),
              s(1)
            ],
          ),
          Spacer(),
          InkWell(
            onTap: (){
              signup=!signup;
              setState(() {

              });
            },
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: signup?'Not New here ?  ':"New Here to the App?  ",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,fontSize: 15,color: Colors.grey
                      ),
                    ),
                    TextSpan(
                      text: signup?'Login Now':"SignUp Now",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          s( 20,),
        ],
      ),
    );
  }

  Widget ci(String url)=>CircleAvatar(
    backgroundImage: NetworkImage(url),radius: 30,
  );

  Widget s(double w)=>SizedBox(height: w,);

  Future<void> checkAndCreateUser(String uid) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('Users').doc(uid);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        // Create a safe default user
        UserModel user = UserModel(
          name: '',
          id: uid,
          pic: '',
          task: [],
        );

        await docRef.set(user.toJson());
        print('✅ User created: $uid');
      } else {
        print('ℹ️ User already exists: $uid');
      }
    } catch(e) {
      print("fkdfk");
    }}
}
