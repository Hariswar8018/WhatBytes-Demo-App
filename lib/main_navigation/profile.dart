import 'package:flutter/material.dart';

import '../card/tasklist.dart';
import '../global.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My Completed Tasks",style: TextStyle(color: Colors.white),),
        backgroundColor: Global.uppercolor,
      ),
      body:  TaskList(selected: true),
    );
  }
}
