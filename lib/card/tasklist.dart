import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:task_app/model/taskmodel.dart';

import '../global.dart';

class TaskList extends StatelessWidget {
  final bool selected; // filter for completed or not
  final String givenPriority; // optional priority filter

  final String searchable ;
  const TaskList({
    super.key,
    required this.selected,
    this.givenPriority="",this.searchable=""
  });

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    Query<Map<String, dynamic>> baseQuery = searchable.isNotEmpty?FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Tasks")
        .where("title",isEqualTo: searchable).orderBy("dueDate",descending: false):

    (givenPriority.isNotEmpty?FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Tasks")
        .where("priority", isEqualTo: givenPriority).orderBy("dueDate",descending: false):

    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Tasks")
        .where("completed", isEqualTo: selected).orderBy("dueDate",descending: false));

    if (givenPriority != null && givenPriority!.isNotEmpty) {
      final priorityInt = int.tryParse(givenPriority!);
      if (priorityInt != null) {
        baseQuery = baseQuery.where("priority", isEqualTo: priorityInt);
      }
    }

    return StreamBuilder<QuerySnapshot>(
      stream: baseQuery.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No tasks found."));
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          padding:EdgeInsets.only(top:7),
          itemBuilder: (context, index) {
            final task = TaskModel.fromJson(docs[index].data() as Map<String, dynamic>);
            return TaskCard(
              task: task,
            );
          },
        );

      },
    );
  }
}

class TaskCard extends StatefulWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool on = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){setState(() {
        on=!on;
      });
      },
      child:on? Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.circle_outlined, color: Global.uppercolor),
              title: Text(widget.task.title ?? "No Title"),
              subtitle: Text(
                formatDateTimeSmart(widget.task.dueDate),
                style: const TextStyle(fontSize: 10),
              ),
              trailing: trailing(widget.task.priority),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 6),
              child: Text(widget.task.description,textAlign: TextAlign.left,),
            ),
            widget.task.completed?Icon(Icons.verified,color: Colors.blue,): InkWell(
              onTap: completemark,
              child: Padding(
                padding:const EdgeInsets.symmetric(horizontal: 30.0,vertical: 6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.green,width: 1
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified,color: Colors.green,),
                        Text("   Mark as Completed",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w800),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 9,)
          ],
        ),
      ):Dismissible(
        key: Key(widget.task.id), // Unique key
        background: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Icon(Icons.check, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            await delete();
            return false; // prevent default dismiss
          } else if (direction == DismissDirection.endToStart) {
            print (":nfdnfcdvn"); // Swipe Left → Delet
            await completemark();
            return true; // allow default dismiss animation
          }
          return false;
        },
        child: Card(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.circle_outlined, color: Global.uppercolor),
            title: Text(widget.task.title ?? "No Title"),
            subtitle: Text(
              formatDateTimeSmart(widget.task.dueDate),
              style: const TextStyle(fontSize: 10),
            ),
            trailing: trailing(widget.task.priority),
          ),
        ),
      )
    );
  }

  Widget trailing(str){
    return Container(
      decoration: BoxDecoration(
         border: Border.all(
           color: s(str),width: 1.5
         )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 13),
        child: Text(str,style: TextStyle( color: Colors.black,fontWeight: FontWeight.w800),),
      ),
    );
  }
  Color s(str){
    if(str=="High"){
      return Colors.red.shade200;
    }else if(str=="Low"){
      return Colors.greenAccent;
    }else if(str=="Medium"){
      return Colors.orange;
    }else{
      return Colors.red.shade300;
    }
  }

  String formatDateTimeSmart(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dtDay = DateTime(dt.year, dt.month, dt.day);

    final timeStr = DateFormat.jm().format(dt); 

    if (dtDay == today) {
      return timeStr;
    } else if (dtDay == tomorrow) {
      return "Tomorrow at $timeStr";
    } else {
      final dateStr = DateFormat('dd/MM/yyyy').format(dt);
      return "$timeStr on $dateStr";
    }
  }

  Future<void> completemark() async {
    await FirebaseFirestore.instance.collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("Tasks")
        .doc(widget.task.id).update({
      "completed":true,
    });
  }
  Future<void> delete() async {
    await FirebaseFirestore.instance.collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection("Tasks")
        .doc(widget.task.id).delete();
  }
}
