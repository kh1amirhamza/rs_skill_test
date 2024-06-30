import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainPageController extends GetxController {
  int selectedNavBarIndex = 0;
 // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentTabController navController =
  PersistentTabController(initialIndex: 0);
}
