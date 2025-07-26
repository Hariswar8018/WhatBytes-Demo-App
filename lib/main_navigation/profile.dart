import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../card/tasklist.dart';
import '../global.dart';
import '../login/onboarding.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My Completed Tasks",style: TextStyle(color: Colors.white),),
        backgroundColor: Global.uppercolor,
        actions: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OnboardingPage()));
            },
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.8),
              child: Icon(Icons.login,color: Colors.red,),
            ),
          ),
          SizedBox(width: 8,),
        ],
      ),
      body:  TaskList(selected: true),
    );
  }
}
