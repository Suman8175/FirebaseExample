import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExceptionFromFirebase {
  void firebaseemailEception(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.blue,
        fontSize: 16.0);
  }
}
