import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//to get a popup message dialuge whenever user do some function
void showAddToFavMeaasge() {
  Fluttertoast.showToast(
      msg: "Add to favourite",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: 16.0);
}

void showRemoveFromFavMessage() {
  Fluttertoast.showToast(
      msg: "Removed from favourite",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: 16.0);
}

void warningMessage() {
  Fluttertoast.showToast(
      msg: "Can't remove from here goto favourite screen",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: 16.0);
}
