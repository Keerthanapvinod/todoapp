

import 'package:flutter/material.dart';

void showErrorMessege(
  BuildContext context,{
   required String message,}){
    final snackBar = SnackBar(
      content:Text(
      message,
      style: TextStyle(
        color: Colors.white),
        ),
    backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
   
   void showSuccessMessege(
    BuildContext context,{
    required String message}){
    final snackBar = SnackBar(content:Text(message,style: TextStyle(color: Colors.black),),
    backgroundColor: Colors.white,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }