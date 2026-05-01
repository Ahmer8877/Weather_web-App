import 'package:flutter/material.dart';
import 'package:weather_web/main.dart';


  void showMsg(String? msg){

    scaffoldMessenger.currentState!.showSnackBar(SnackBar(content: Text(msg!),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    )
    );
  }
