import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttterchat/api_connection_php/api_connection.dart';
import 'package:fluttterchat/users/authentication/signup_screen.dart';
import 'package:fluttterchat/users/screens/dashboard_of_screens.dart';
import 'package:fluttterchat/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';
import 'package:fluttterchat/users/model/user.dart';
import "package:http/http.dart" as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  //CONTROLLERS
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //hide or show password
  var isObsecure = true.obs;

  LoginUserNow() async {
    //for it all to work well use try catch method

    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email": emailController.text.trim(),
          "user_password": passwordController.text.trim()
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin =
            jsonDecode(res.body); // note we are usinf decode instead of encode
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(msg: "Signin successfully");

          //we assigned to userino to remember

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);
          //SAVE USERINFO TO LOCAL STORAGE USING SHARED PREFERENCES
          //FIRST CREATE A CLASS
          //call the created method and pass userInfo who logged in succefully
          await RememberUserPrefs.saveRememberUser(userInfo);

          //send to dashboard screen if that okay
          //to add someDelay before that to next screen
          Future.delayed(Duration(milliseconds: 2000), () {
            Get.to(DashboardOfScreens());
          });
        } else {
          Fluttertoast.showToast(msg: "Incorect credentials, try again");
        }
      }
    } catch (errMsg) {
      print("Error : :" + errMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset(
                      "images/download.png",
                      fit: BoxFit.cover,
                    )),

                //sign in form

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(179, 235, 222, 222),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            color: Color.fromARGB(255, 239, 236, 236),
                            offset: Offset(0, -3))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                //email form
                                TextFormField(
                                  controller: emailController,
                                  validator: (val) => val == ""
                                      ? "Write an email pleae!"
                                      : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    hintText: "Enter an email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white60),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 6),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                //password form   THIS OBX is because we are using getx

                                Obx(
                                  () => TextFormField(
                                    controller: passwordController,
                                    obscureText: isObsecure.value,
                                    validator: (val) => val == ""
                                        ? "Write an password pleae!"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_sharp,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: Obx(() => GestureDetector(
                                            onTap: () => {
                                              isObsecure.value =
                                                  !isObsecure.value
                                            },
                                            child: Icon(
                                              isObsecure.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility_outlined,
                                              color: Colors.black,
                                            ),
                                          )),
                                      hintText: "Enter an password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 6),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                //button using material
                                Material(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () {
                                      //before calling the method we have to validate with the if statement

                                      if (formKey.currentState!.validate()) {
                                        LoginUserNow();
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 28, vertical: 10),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Dont have an account?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 3, 157, 185)),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(const SignupScreen());
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 215, 50, 4)),
                                  ))
                            ],
                          ),
                          const Text(
                            'Or',
                            style:
                                TextStyle(fontSize: 16, color: Colors.purple),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Are you the site Admin?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 3, 157, 185)),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(color: Colors.amber),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
