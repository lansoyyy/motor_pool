import 'package:car_rental/screens/about_us.dart';
import 'package:car_rental/screens/admin/admin_calendar.dart';
import 'package:car_rental/screens/admin/admin_record.dart';
import 'package:car_rental/screens/admin/admin_req.dart';
import 'package:car_rental/screens/admin/vehicle_out_tab.dart';
import 'package:car_rental/screens/auth/login_screen.dart';
import 'package:car_rental/screens/tabs/notif_tab.dart';
import 'package:car_rental/screens/tabs/request_tab.dart';
import 'package:car_rental/screens/vehicles_screen.dart';
import 'package:car_rental/utils/constant.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final UserType? userType;

  const HomeScreen({Key? key, this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
    // .collection('User')
    // .doc(FirebaseAuth.instance.currentUser!.uid)
    // .snapshots();
    return DefaultTabController(
      length: userType == UserType.admin ? 3 : 2,
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    opacity: 150.0,
                    image: AssetImage('assets/images/back.png'),
                    fit: BoxFit.cover,
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
                          TextBold(
                              text:
                                  'Physical Plant Maintenance Unit Motorpool Department',
                              fontSize: 28,
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 600,
                            child: TabBar(
                                labelStyle: const TextStyle(
                                    fontFamily: 'QBold', fontSize: 18),
                                tabs: [
                                  const Tab(
                                    text: 'Request',
                                  ),
                                  Tab(
                                    text: userType == UserType.user
                                        ? 'Notification'
                                        : 'Record',
                                  ),
                                  Tab(
                                      text: userType == UserType.admin
                                          ? 'Vehicle Out'
                                          : ''),
                                ]),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AboutUsPage()));
                              },
                              child: TextBold(
                                  text: 'About us',
                                  fontSize: 18,
                                  color: Colors.white)),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => VehiclesScreen(
                                          userType: userType,
                                        )));
                              },
                              child: TextBold(
                                  text: 'Our vehicles',
                                  fontSize: 18,
                                  color: Colors.white)),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => AdminCalendar(
                                              usertype:
                                                  userType == UserType.user
                                                      ? UserType.user
                                                      : UserType.admin,
                                            )));
                              },
                              child: TextBold(
                                  text: 'Calendar',
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
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: TextBold(
                                            text: 'Logout Confirmation',
                                            color: Colors.black,
                                            fontSize: 14),
                                        content: TextRegular(
                                            text:
                                                'Are you sure you want to logout?',
                                            color: Colors.black,
                                            fontSize: 16),
                                        actions: <Widget>[
                                          MaterialButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: TextBold(
                                                text: 'Close',
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()));
                                            },
                                            child: TextBold(
                                                text: 'Continue',
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ));
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: SizedBox(
                        child: TabBarView(children: [
                          userType == UserType.user
                              ? const RequestTab()
                              : AdminRequest(),
                          userType == UserType.user
                              ? NotifTab()
                              : AdminRecord(),
                          userType == UserType.admin
                              ? const VehicleOutTab()
                              : const SizedBox()
                        ]),
                      )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
