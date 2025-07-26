import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:task_app/send.dart';

import '../global.dart';
import '../model/taskmodel.dart';


class Services extends StatefulWidget {

  Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dueDateController = TextEditingController();

  String id = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Add Tasks",style: TextStyle(color: Colors.white),),
        backgroundColor: Global.uppercolor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Global.text("     Type Task Name"),
          Global.textFieldEditor(
            controller: titleController,
            hint: "Title",
          ),
          const SizedBox(height: 10),
          Global.text("     Description"),
          Global.textFieldEditor(
            controller: descriptionController,
            hint: "Description",
          ),
          const SizedBox(height: 10),
          Global.text("     Due Date "),
          Global.textFieldEditor(
            controller: dueDateController,
            hint: "Due Date",
            inputType: TextInputType.datetime,isread: true
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate:
                  DateTime(1600).subtract(const Duration(days: 3652)),
                  lastDate: DateTime.now().add(
                    const Duration(days: 3652),
                  ),
                  is24HourMode: false,
                  isShowSeconds: false,
                  minutesInterval: 1,
                  secondsInterval: 1,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 650,
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1.drive(
                        Tween(
                          begin: 0,
                          end: 1,
                        ),
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 200),
                  barrierDismissible: true,
                  selectableDayPredicate: (dateTime) {
                    // Disable 25th Feb 2023
                    if (dateTime == DateTime(2023, 2, 25)) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                );
                if(dateTime!=null){
                  selected=dateTime;
                  final formattedDate = formatDateTime(dateTime); // "27/07/25 on 14:30"
                  setState(() {
                    dueDateController.text=formattedDate;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Global.container("Select Due Date", w),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Global.text("     Task Prority "),
          SizedBox(height: 4,),
          Row(
            children: [
              SizedBox(width: 18,),
              a("Low"),  SizedBox(width: 9,),
              a("Medium"),  SizedBox(width: 9,),
              a("High")
            ],
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: () async {
              if(selected==now||titleController.text.isEmpty){
                Send.showMessage(context, "Select Date or title can't be Empty", false);
                return ;
              }
              try {
                final task = TaskModel(
                  id: id,
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  dueDate: selected,
                  priority: priority, completed: false,
                );
                await FirebaseFirestore.instance.collection("Users")
                    .doc(FirebaseAuth.instance.currentUser!.uid).collection("Tasks")
                    .doc(id).set(task.toJson());
                Send.showMessage(context, "Task Created", true);
                setState(() {
                  titleController.clear();
                  descriptionController.clear();
                  selected=DateTime.now();
                  dueDateController.clear();
                  priority="Low";
                  id = DateTime.now().toString();
                });
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invalid input: $e")),
                );
              }
            },
            child: Center(child: Global.container("Add Task", w+90)),
          ),
        ],
      ),
    );
  }

  Widget a(str){
    return InkWell(
      onTap: (){
        priority=str;
        setState(() {

        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: s(str)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13),
          child: Text(str),
        ),
      ),
    );
  }
  Color s(str){
    if(str!=priority){
      return Colors.grey.shade200;
    }else if(priority=="Low"){
      return Colors.greenAccent;
    }else if(priority=="Medium"){
      return Colors.orange;
    }else{
      return Colors.red.shade300;
    }
  }

  String priority = "Low";

  DateTime now = DateTime.now();

  late DateTime selected;
  void initState(){
    selected=now;
  }
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yy \'on\' HH:mm').format(dateTime);
  }
}
