import 'dart:convert';

import 'package:fluttterchat/users/model/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  //save user info to remember users logged in
  //serch for shared_preferences package from pubdev
  static Future<void> saveRememberUser(User userInfo) async {
    //CREATE AN INSTANCE OF SHARED PREFENCE WITH WHICH WE CAN REM USER DATA
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //convert to json data
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  //get-read user info
  static Future<User?> readUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if (userInfo != null) {
      try {
        Map<String, dynamic> userDataMap = jsonDecode(userInfo);
        User currentUserInfo = User.fromJson(userDataMap);
        return currentUserInfo;
      } catch (e) {
        // Handle JSON decoding errors, e.g., when the stored data is not in the expected format
        print("Error decoding user info: $e");
      }
    }

    // Return null if no user info is found or if there was an error decoding it
    return null;
  }

//deleting user info from localstorage
  static Future<void> removeUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}
