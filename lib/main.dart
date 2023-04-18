import 'package:car_rental/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCsuE6hVHTLyGzK8rfVGLAvQlgF_uimUDQ",
          appId: "1:335301664598:web:eb465d2051f6c6e4b980f7",
          messagingSenderId: "335301664598",
          projectId: "moto-e9a4b",
          storageBucket: "moto-e9a4b.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motorpool',
      home: LoginScreen(),
    );
  }
}
