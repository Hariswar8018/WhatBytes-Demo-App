import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_app/global.dart';
import 'package:task_app/login/login.dart';

class OnboardingPage extends StatefulWidget {
   OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  int i = 0;

  void proceed(){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));

  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Global.globalwhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          SizedBox(height: 120,),
         Padding(
           padding: const EdgeInsets.all(20.0),
           child: Container(
             width: w,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Image.asset("assets/login.png",width: 90,),
                 SizedBox(height: 14,),
                 Text("Get Things Done",style: TextStyle(fontWeight: FontWeight.w800,color: Global.blueg,fontSize: 24),),
                 SizedBox(height: 4,),
                 Text("Just a Click away from",style: TextStyle(fontSize:17,fontWeight: FontWeight.w800,color: Colors.grey.shade400),),
                 Text("Planning your tasks",style: TextStyle(fontSize:17,fontWeight: FontWeight.w800,color:Colors.grey.shade400),),
               ],
             ),
           ),
         ),
         Spacer(),
          InkWell(
            onTap: proceed,
            child: Stack(
              children: [
                Container(
                  width: w,
                  height: 150,
                ),
                Positioned(
                  left: w*5/8,
                  child: CustomPaint(
                    size: const Size(300, 300),
                    painter: QuarterCirclePainter(),
                  ),
                ),
                     Row(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               Spacer(),
               Padding(
                 padding: const EdgeInsets.only(top: 50.0),
                 child: Icon(Icons.arrow_forward_rounded,size: 70,color: Colors.white,),
               ),
               SizedBox(width: 19,)
             ],
                     )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class QuarterCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, pi , pi / 2, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}