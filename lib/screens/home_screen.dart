import 'package:car_rental/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            opacity: 120.0,
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
                  Image.asset(
                    'assets/images/profile.png',
                    height: 120,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextBold(
                        text:
                            'Physical Plant Maintenance Unit Motorpool Department',
                        fontSize: 28,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
