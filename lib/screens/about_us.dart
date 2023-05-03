import 'package:car_rental/screens/auth/login_screen.dart';
import 'package:car_rental/utils/constant.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final AboutusUsage? usage;

  const AboutUsPage({super.key, this.usage = AboutusUsage.homePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (usage == AboutusUsage.loginPage) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xff6571E0),
        title: const Text(
          'About Us',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'QBold',
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 150.0,
            image: AssetImage('assets/images/back.png'),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/profile.png',
                height: 120,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Physical Plant Maintenance Unit Motorpool Department',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'QBold',
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 150, right: 150),
                child: Text(
                  'We are a team of dedicated professionals who are responsible for maintaining the motorpool fleet of the Physical Plant Maintenance Unit. Our mission is to ensure that all vehicles are safe and roadworthy, and to provide reliable transportation services for the department and its employees.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'QRegular',
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Contact Us',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'QBold',
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Phone: (123) 456-7890',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'QBold', color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Email: motorpool@ppmu.example.com',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'QBold', color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
