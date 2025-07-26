import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../card/tasklist.dart';
import '../global.dart';

class Home extends StatelessWidget {
  Home({super.key});
  String getTodayVerbose() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = DateFormat('MMMM').format(now); // Full month name
    final weekday = DateFormat('EEEE').format(now); // Full weekday name
    return "$day, $month ($weekday)";
  }

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: w,
            height: 170,
            color: Global.uppercolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                  children: [SizedBox(width: 10,),
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: Icon(Icons.dashboard),
                    ),
                    Container(
                        width: w*3/4,
                        child: Global.textFieldEditor(controller: search)),
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: Icon(Icons.menu),
                    ),
                    SizedBox(width: 8,)
                  ],
                ),
                s(15),
                Text("    Today ${getTodayVerbose()}",style: TextStyle(fontSize: 15,color: Colors.white),),
                Text("   My Tasks",style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.w900),),
                s(8)
              ],
            ),
          ),
          SizedBox(height: 6,),
          Row(
            children: [
              Text("  Upcoming Tasks",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
              Spacer(),
              Text("☰  Filter    ",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w800),)
            ],
          ),
          Container(
            height: h-280,
            width: w,
            child: TaskList(selected: false,givenPriority: "",searchable: search.text,)
          )
        ],
      ),
    );
  }
  String givenpriority = "";
  DateTime now = DateTime.now();

  Widget s(double w)=>SizedBox(height: w,);

}
