import 'package:car_rental/screens/about_us.dart';
import 'package:car_rental/screens/tabs/notif_tab.dart';
import 'package:car_rental/screens/tabs/request_tab.dart';
import 'package:car_rental/screens/vehicles_screen.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                      width: 20,
                    ),
                    SizedBox(
                      width: 500,
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
                      width: 400,
                      child: TabBar(
                          labelStyle:
                              TextStyle(fontFamily: 'QBold', fontSize: 15),
                          tabs: [
                            Tab(
                              text: 'Request',
                            ),
                            Tab(
                              text: 'Notification',
                            ),
                          ]),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const Expanded(
                    child: SizedBox(
                  child: TabBarView(children: [
                    RequestTab(),
                    NotifTab(),
                  ]),
                )),
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
                          onPressed: () {},
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
      ),
    );
  }
}
