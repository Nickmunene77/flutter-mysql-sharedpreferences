import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttterchat/api_connection_php/api_connection.dart';
import 'package:fluttterchat/users/authentication/login_screen.dart';
import 'package:fluttterchat/users/model/user.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();

  //CONTROLLERS
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //hide or show password
  var isObsecure = true.obs;

  validateUserEmail() async {
    try {
      var res = await http.post(Uri.parse(API.validateEmail), body: {
        'user_email': emailController.text.trim(),
      });

      //200 means success
      if (res.statusCode == 200) {
        var resBodyOfValidateEmail = jsonDecode(res.body);

        //if success== true the length of row =1  user already exist
        //use fluttertoast package to show a text

        //email found is the key from the php backend

        if (resBodyOfValidateEmail['emailFound'] == true) {
          Fluttertoast.showToast(msg: "Email is already taken");
        } else {
          //register the user

          registerAndSaveUserRecord() async {}
          User userModel = User(1, nameController.text.trim(),
              emailController.text.trim(), passwordController.text.trim());

          try {
            var res = await http.post(
              Uri.parse(API.signup),
              body: userModel.toJson(),
            );

            if (res.statusCode == 200) {
              var resBodyOfSignup = jsonDecode(res.body);
              if (resBodyOfSignup['success'] == true) {
                Fluttertoast.showToast(msg: "Sign up successfully");

                //to clear the fields
                setState(() {
                  nameController.clear();
                  emailController.clear();
                  passwordController.clear();
                });
              } else {
                Fluttertoast.showToast(msg: "Error occured");
              }
            }
          } catch (err) {
            print(err.toString());
            Fluttertoast.showToast(msg: err.toString());
          }
        }
      }
    } catch (err) {
      print(err.toString());
      Fluttertoast.showToast(msg: err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                      "images/register.jpg",
                      fit: BoxFit.cover,
                    )),

                //sign up form

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
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

                                //name field
                                TextFormField(
                                  controller: nameController,
                                  validator: (val) => val == ""
                                      ? "Write your name please!"
                                      : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    hintText: "Enter your name",
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
                                  height: 24,
                                ),

                                //email field
                                TextFormField(
                                  controller: emailController,
                                  validator: (val) => val == ""
                                      ? "Write an email please!"
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
                                  height: 24,
                                ),

                                //password form   THIS OBX is because we are using getx

                                Obx(
                                  () => TextFormField(
                                    controller: passwordController,
                                    obscureText: isObsecure.value,
                                    validator: (val) => val == ""
                                        ? "Write an password please!"
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
                                  height: 24,
                                ),

                                //button using material
                                Material(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        //validate the user email unique
                                        //call the function for that
                                        validateUserEmail();
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 28, vertical: 10),
                                      child: Text(
                                        "SignUp",
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
                                "Already have an account?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 3, 157, 185)),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(const LoginScreen());
                                  },
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 215, 4, 169)),
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
