import 'dart:ui';

import 'package:flutter/material.dart';

class Global{

  static Color globalcolor = Color(0xff686AF7);

  static Color globalwhite = Color(0xffFFFFFF);

  static Color uppercolor=Color(0xff888AF5);

  static Color orange=Color(0xffF9AA24);

  static Color blueg=Color(0xff59647C);

  static Widget text(String str) =>  Text(str,style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600,fontSize: 17),);
  static Widget textFieldEditor({
    required TextEditingController controller,
    String? hint,
    TextInputType inputType = TextInputType.text,
    bool isread = false
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextFormField(
        controller: controller,readOnly: isread,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Color(0xffF3F8FF),
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
      ),
    );
  }

  static Widget container(String str,double w)=>Container(
      width: w*5/8,
      decoration: BoxDecoration(
        color: Global.globalcolor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 12),
        child: Center(child: Text(str,style: TextStyle(color: Colors.white,fontSize: 15),)),
      )
  );
}