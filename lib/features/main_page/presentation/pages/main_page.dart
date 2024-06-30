import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rs_skill_test/features/branch/presentation/pages/branch_page.dart';
import 'package:rs_skill_test/features/transaction/presentation/pages/transaction_page.dart';

import '../../../../core/utils/constants.dart';
import '../../../customer_suplier/presentation/pages/customer_supplier_list_page.dart';
import '../widgets/custom_start_dower_widgets.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../controllers/main_page_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [

    PersistentBottomNavBarItem(
      icon: const Icon(Icons.dashboard_customize_outlined),
      title: ("Customer"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.group_work_outlined),
      title: ("Branch"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.account_balance_wallet_outlined),
      title: ("Transaction"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_outline_rounded),
      title: ("Profile"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}

List<Widget> _buildScreens() {
  return [
    const CustomerSupplierListPage(),
    const BranchPage(),
    const TransactionPage(),
    const ProfilePage(),
  ];
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: GetBuilder<MainPageController>(
          //  init: Get.find<MainPageController>(),
            builder: (controller) {
      return Scaffold(
          key: scaffoldKey,
          drawer: CustomStartDower(),
          body: PersistentTabView(
            context,
            controller: controller.navController,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move the screen up when the keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'true' to hide the navigation bar when the keyboard appears. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style1, // Choose the nav bar style with this property.
          ));
    }));
  }
}
