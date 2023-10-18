import 'package:flutter/material.dart';
import 'package:fluttterchat/users/authentication/login_screen.dart';
import 'package:fluttterchat/users/model/user.dart';
import 'package:fluttterchat/users/screens/dashboard_of_screens.dart';
import 'package:fluttterchat/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The main function is the entry point of the Flutter application
Future<void> main() async {
  // Ensure that Flutter is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  await SharedPreferences.getInstance();

  // Run the app by creating an instance of MyApp
  runApp(const MyApp());
}

// MyApp is a StatelessWidget that represents the root of your application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Set the title of the app
      title: 'Luxurious Store',

      // Disable the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,

      // Define the theme for your app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // The home property defines the initial screen of the app
      home: FutureBuilder<User?>(
        // The future will keep the user logged in even after switching phones if logged
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot) {
          // Check if user info is available
          if (dataSnapShot.data == null) {
            // If no user info is found, show the LoginScreen
            return const LoginScreen();
          } else {
            // If user info is found, show the DashboardOfScreens
            return DashboardOfScreens();
          }
        },
      ),
    );
  }
}

// ... rest of your code remains the same ...
