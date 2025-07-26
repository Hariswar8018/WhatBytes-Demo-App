

import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';

import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:task_app/main_navigation/profile.dart';
import 'package:task_app/main_navigation/services.dart';
import '../bloc/userbloack_bloc.dart';
import '../bloc/userbloack_event.dart';
import '../bloc/userbloack_state.dart';
import  '../model/usermodel.dart';
import 'home.dart';


const List<TabItem> items = [
  TabItem(
      icon: Icons.home,
      title: ""
  ),
  TabItem(
    icon: Icons.add_rounded,
    title: 'Add',
  ),
  TabItem(
    icon: Icons.calendar_month,
    title: ""
  ),

];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int visit = 0;
  double height = 30;
  Color colorSelect =const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const  Color(0XFF1752FE);
  Widget as(int i ){
    if( i == 1){
      return Services();
    }else if(i == 0){
      return Home();
    }else{
      return Profile();
    }
  }
  void initState(){
    v();
  }

  v(){
    String id = FirebaseAuth.instance.currentUser!.uid;
    context.read<UserBloc>().add(LoadUser(id));
  }

  String ay(i){
    if( i == 0){
      return "Services";
    }else if(i == 1){
      return "Home";
    }else if(i == 2){
      return "Home";
    }else if(i == 3){
      return "Approvals";
    }else{
      return "More";
    }
  }

  @override
  Widget build(BuildContext context) {
    String? df=FirebaseAuth.instance.currentUser!.email;
      return  WillPopScope(
        onWillPop: () async {
          bool exit = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Exit App'),
                content: Text('Are you sure you want to exit?'),
                actions: [
                  ElevatedButton(
                    child: Text('No'),
                    onPressed: () {
                      // Return false to prevent the app from exiting
                      Navigator.of(context).pop(false);
                    },
                  ),
                  ElevatedButton(
                    child: Text('Yes'),
                    onPressed: () {
                      // Return true to allow the app to exit
                      Navigator.of(context).pop(true);
                      SystemNavigator.pop();
                    },
                  ),
                ],
              );
            },
          );
          return exit ?? false;
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Image.asset("assets/gigs.gif",width: MediaQuery.of(context).size.width/2,)),
                    Center(child: Text("Finding User",style: TextStyle(fontWeight: FontWeight.w600),)),
                  ],
                ),
              );
            } else if (state is UserLoaded) {
              return  Scaffold(
                body: as(visit),
                bottomNavigationBar: Container(
                  child: BottomBarCreative(
                    items: items,
                    backgroundColor: Colors.white,
                    color: Colors.black,
                    colorSelected: colorSelect,
                    indexSelected: visit,
                    isFloating: true,
                    highlightStyle: const HighlightStyle(
                        sizeLarge: true, isHexagon: true, elevation: 2),
                    onTap: (int index) =>
                        setState(() {
                          visit = index;
                        }),
                  ),
                ),
              );
            } else if (state is UserError) {
              return Scaffold(body: Center(child: Text("Error: ${state.message}")));
            }
            return Container();
          },
        )

      );
    }
}