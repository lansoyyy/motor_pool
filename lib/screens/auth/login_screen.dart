import 'package:car_rental/screens/about_us.dart';
import 'package:car_rental/screens/home_screen.dart';
import 'package:car_rental/screens/vehicles_screen.dart';
import 'package:car_rental/services/add_user.dart';
import 'package:car_rental/utils/constant.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void logInWithGoogle(context) async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      final googleSignInAuth = await googleSignInAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(
                userType: UserType.user,
              )));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

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
              SingleChildScrollView(
                child: Container(
                  color: Colors.white.withOpacity(0.8),
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
                            isObscure: true,
                            label: 'Password',
                            controller: passController),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonWidget(
                            label: 'Login',
                            onPressed: (() async {
                              if (emailController.text == 'admin' &&
                                  passController.text == 'admin') {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => const HomeScreen(
                                              userType: UserType.admin,
                                            )));
                              } else {
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passController.text);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(
                                                userType: UserType.user,
                                              )));
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
                                        backgroundColor:
                                            Colors.white.withOpacity(0.8),
                                        child: Container(
                                          color: Colors.white.withOpacity(0.5),
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
                                                    controller:
                                                        newNameController),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFieldWidget(
                                                    label: 'Email',
                                                    controller:
                                                        newEmailController),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFieldWidget(
                                                    label: 'Password',
                                                    controller:
                                                        newPassController),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                ButtonWidget(
                                                    label: 'Register',
                                                    onPressed: (() async {
                                                      try {
                                                        await FirebaseAuth
                                                            .instance
                                                            .createUserWithEmailAndPassword(
                                                                email:
                                                                    newEmailController
                                                                        .text,
                                                                password:
                                                                    newPassController
                                                                        .text);
                                                        addUser(
                                                            newNameController
                                                                .text,
                                                            newEmailController
                                                                .text,
                                                            newPassController
                                                                .text);
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: TextRegular(
                                                                text:
                                                                    'Account created succesfully!',
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        );
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: TextRegular(
                                                                text: e
                                                                    .toString(),
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Divider(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextBold(
                                  text: 'or',
                                  fontSize: 14,
                                  color: Colors.black),
                              const SizedBox(
                                width: 10,
                              ),
                              const SizedBox(
                                width: 100,
                                child: Divider(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            minWidth: 225,
                            height: 45,
                            color: Colors.white,
                            onPressed: () {
                              logInWithGoogle(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/google.png',
                                    height: 25),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextRegular(
                                    text: 'Signup with Google',
                                    fontSize: 14,
                                    color: Colors.black),
                              ],
                            ))
                      ],
                    ),
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
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const AboutUsPage(
                                        usage: AboutusUsage.loginPage,
                                      )));
                        },
                        child: TextBold(
                            text: 'About us',
                            fontSize: 18,
                            color: Colors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const VehiclesScreen(
                                        usage: AboutusUsage.loginPage,
                                      )));
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
