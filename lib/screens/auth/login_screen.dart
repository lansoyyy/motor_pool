import 'package:car_rental/screens/about_us.dart';
import 'package:car_rental/screens/vehicles_screen.dart';
import 'package:car_rental/services/add_user.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final newEmailController = TextEditingController();
  final newPassController = TextEditingController();
  final newNameController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 150.0,
            image: AssetImage('assets/images/back.png'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Image.asset(
                    'assets/images/profile.png',
                    height: 120,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 800,
                    child: TextBold(
                        text:
                            'Physical Plant Maintenance Unit Motorpool Department',
                        fontSize: 28,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                color: Colors.white,
                height: 375,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                          label: 'Email', controller: emailController),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'Password', controller: passController),
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonWidget(
                          label: 'Login',
                          onPressed: (() async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passController.text);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: TextRegular(
                                      text: e.toString(),
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              );
                            }
                          })),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      child: Container(
                                    color: Colors.white,
                                    height: 375,
                                    width: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextFieldWidget(
                                              label: 'Full Name',
                                              controller: newNameController),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldWidget(
                                              label: 'Email',
                                              controller: newEmailController),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldWidget(
                                              label: 'Password',
                                              controller: newPassController),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          ButtonWidget(
                                              label: 'Register',
                                              onPressed: (() async {
                                                try {
                                                  await FirebaseAuth.instance
                                                      .createUserWithEmailAndPassword(
                                                          email: emailController
                                                              .text,
                                                          password:
                                                              passController
                                                                  .text);
                                                  addUser(
                                                      newNameController.text,
                                                      emailController.text,
                                                      passController.text);
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: TextRegular(
                                                          text: e.toString(),
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                }
                                              })),
                                        ],
                                      ),
                                    ),
                                  ));
                                });
                          },
                          child: TextBold(
                              text: 'Register',
                              fontSize: 14,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const AboutUsPage()));
                        },
                        child: TextBold(
                            text: 'About us',
                            fontSize: 18,
                            color: Colors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VehiclesScreen()));
                        },
                        child: TextBold(
                            text: 'Our vehicles',
                            fontSize: 18,
                            color: Colors.white)),
                    TextButton(
                        onPressed: () async {
                          const buksu = 'https://buksu.edu.ph/';
                          if (await canLaunch(buksu)) {
                            await launch(buksu);
                          } else {
                            throw 'Could not launch $buksu';
                          }
                        },
                        child: TextBold(
                            text: 'University Link',
                            fontSize: 18,
                            color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
