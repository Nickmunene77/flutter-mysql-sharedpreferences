import 'package:flutter/material.dart';
import 'package:fluttterchat/users/authentication/login_screen.dart';
import 'package:fluttterchat/users/userPreferences/current_user.dart';
import 'package:fluttterchat/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
//display the name as that of current user
//get current user info with below
  final CurrentUser _currentUser = Get.put(CurrentUser());

  //method to signout user
  signOutUser() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Logout",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: const Text("Are you sure \nyou want to logout?"),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("No")),
          TextButton(
              onPressed: () {
                //loggedOut is the key
                Get.back(result: "LoggedOut");
              },
              child: const Text("Yes"))
        ],
      ),
    );
    if (resultResponse == "LoggedOut") {
      //DELETE THE USED DATA FROM PHONE LOCALSTORAGE
      RememberUserPrefs.readUserInfo()
          //send user to LoginScreen
          .then((value) => {Get.off(LoginScreen())});
    }
  }

  //reusable widget
  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(66, 123, 8, 85)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black38,
          ),
          const SizedBox(
            width: 25,
          ),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      //this makes it be like at center
      padding: EdgeInsets.all(32),
      children: [
        const SizedBox(
          height: 30,
        ),
        const Center(
          child: CircleAvatar(
            radius: 100, // Set the radius to 20 to make it 40x40 in total size
            backgroundImage: AssetImage("images/nick.jpg"), // Set the image
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        //the reusable widget used here
        userInfoItemProfile(Icons.person, _currentUser.user.user_name),
        const SizedBox(
          height: 20,
        ),
        userInfoItemProfile(Icons.email, _currentUser.user.user_email),
        const SizedBox(
          height: 20,
        ),

        Center(
          child: Material(
            color: const Color.fromARGB(255, 181, 63, 134),
            borderRadius: BorderRadius.circular(7),
            child: InkWell(
              //get user logged out
              onTap: () {
                //call signup user method
                signOutUser();
              },
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
