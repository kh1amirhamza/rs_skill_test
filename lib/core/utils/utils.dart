import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String formatDate(var date) {
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }

    return DateFormat("d, MMM yyyy").format(dateTime.toLocal());
  }

  static String formatTime(var time) {
    late DateTime dateTime;
    if (time is String) {
      dateTime = DateTime.parse(time);
    } else {
      dateTime = time;
    }

    return DateFormat.jm().format(dateTime.toLocal());
  }

  static String formatDateWithTime(var date) {
    var formatter = DateFormat("yyyy-MM-dd hh:mm aa");
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }

    return formatter.format(dateTime);
  }

  Future<void> launchUrlInBrowser(String url) async {
    Uri urlparsed = Uri.parse(url);
    if (!await launchUrl(urlparsed)) {
      throw Exception('Could not launch $url');
    }
  }

  /// Checks if string is email.
  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  static loadingDialog(
      BuildContext context, {
        bool barrierDismissible = false,
      }) {
    showCustomDialog(
      context,
      child: const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future showCustomDialog(
      BuildContext context, {
        Widget? child,
        bool barrierDismissible = false,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }
}


String userType (String ownerType){
  if(ownerType == "0"){
    return '';
  }else if(ownerType == "1"){
    return "Individual";
  }else if(ownerType == "2"){
    return "Company";
  }else if(ownerType == "3"){
    return "Agency";
  } else if(ownerType == "4"){
    return "Agent";
  }
  return '';
}
