import 'package:flutter/material.dart';
import 'package:fluttterchat/users/screens/home_screen.dart';
import 'package:fluttterchat/users/screens/order_screen.dart';
import 'package:fluttterchat/users/screens/profile_screen.dart';
import 'package:fluttterchat/users/screens/wishlist_screen.dart';
import 'package:fluttterchat/users/userPreferences/current_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DashboardOfScreens extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  List<Widget> _myScreens = [
    HomeScreen(),
    WishlistScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  List _navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.favorite,
      "non_active_icon": Icons.favorite_border,
      "label": "WishList",
    },
    //no icon for orders so we use package form_awesome_flutter
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Order",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile",
    },
  ];
  RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        // either user logged in or not
        _rememberCurrentUser.getUserIfo();
      },
      builder: (controller) {
        return Scaffold(
          body: SafeArea(child: Obx(() => _myScreens[_indexNumber.value])),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
                currentIndex: _indexNumber.value,
                onTap: (value) => {_indexNumber.value = value},
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.amber,
                unselectedItemColor: const Color.fromARGB(255, 3, 21, 53),
                items: List.generate(4, (index) {
                  var navBtnProperty = _navigationButtonsProperties[index];
                  return BottomNavigationBarItem(
                      backgroundColor: Colors.grey[50],
                      icon: Icon(navBtnProperty["non_active_icon"]),
                      activeIcon: Icon(navBtnProperty["active_icon"]),
                      label: navBtnProperty["label"]);
                })),
          ),
        );
      },
    );
  }
}
