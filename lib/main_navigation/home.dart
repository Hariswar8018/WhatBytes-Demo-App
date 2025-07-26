import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/userbloack_bloc.dart';
import '../bloc/userbloack_event.dart';
import '../card/tasklist.dart';
import '../global.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String getTodayVerbose() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = DateFormat('MMMM').format(now); // Full month name
    final weekday = DateFormat('EEEE').format(now); // Full weekday name
    return "$day, $month ($weekday)";
  }

  TextEditingController search = TextEditingController();

  Widget text(str)=> Text(str,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800),);


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
                  children: [SizedBox(width: 3,),
                    Container(
                        width: w*3/4,
                        child:  TextFormField(
                          controller: search,
                          onSaved: (value){
                           if(search!=null){
                             setState((){
                               searchs=value! ;
                             });
                           }
                          },
                          onChanged: (value){
                            setState((){
                              searchs=value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Search Task",
                            filled: true,
                            fillColor: Color(0xffF3F8FF),
                            prefixIcon: Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.blueGrey, width: 1.5),
                            ),
                          ),
                        )),
                    InkWell(
                      onTap: (){
                        showbottom(context,w);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: Icon(Icons.menu),
                      ),
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
          searchs.isNotEmpty? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("  Searchable Tasks",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
            ],
          )
          :InkWell(
            onTap: (){
              showbottom(context,w);
            },
            child: Row(
              children: [
                Text("  Upcoming Tasks",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
                Spacer(),
                Text("☰  Filter    ",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w800),)
              ],
            ),
          ),
          Container(
            height: h-280,
            width: w,
            child: TaskList(selected: givenstatus,givenPriority: givenpriority,searchable: searchs,)
          )
        ],
      ),
    );
  }

  void showbottom(BuildContext context,double w){
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        width: w,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.filter_alt_sharp),
              Text("Filter Tasks",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400),),
              SizedBox(height: 15,),
              text("Filter by Status"),SizedBox(height: 8,),
              Row(
                children: [
                  lisstatus(true,context),
                  lisstatus(false,context)
                ],
              ),
              SizedBox(height: 12,),
              text("Filter by Priority"),SizedBox(height: 8,),
              Row(
                children: [
                  lispriority("All", context),
                  lispriority("Low", context),
                  lispriority("Medium", context),
                  lispriority("High", context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  String givenpriority = "";

  bool givenstatus=false;
  DateTime now = DateTime.now();
  Widget lisstatus(bool b,BuildContext context){
    return InkWell(
      onTap: (){
        setState(() {
          givenpriority="";
          givenstatus=!givenstatus;
        });
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: givenstatus==b?Colors.orange.shade200:Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13),
          child: Text(b?"Completed":"InCompleted"),
        ),
      ),
    );
  }
  Widget lispriority(String b,BuildContext context){
    return InkWell(
      onTap: (){
        setState(() {
          if(b=="All"){
            givenpriority="";
          }else{
            givenpriority=b;
          }
        });
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: b=="All"?(givenpriority==""?Colors.blue.shade200:Colors.grey.shade200):(givenpriority==b?Colors.blue.shade200:Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13),
          child: Text(b),
        ),
      ),
    );
  }
  String searchs ="";

  Widget s(double w)=>SizedBox(height: w,);
}
