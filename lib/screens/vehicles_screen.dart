import 'package:car_rental/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/vehicles.dart';
import '../utils/constant.dart';
import 'auth/login_screen.dart';

class VehiclesScreen extends StatelessWidget {
  final AboutusUsage? usage;
  final UserType? userType;

  const VehiclesScreen(
      {super.key,
      this.usage = AboutusUsage.homePage,
      this.userType = UserType.user});

  @override
  Widget build(BuildContext context) {
    print(userType);
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
          'Our Vehicles',
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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Cars').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )),
                );
              }

              final data = snapshot.requireData;
              return GridView.builder(
                  itemCount: data.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Scaffold(
                        floatingActionButton: userType == UserType.admin
                            ? FloatingActionButton(
                                child: const Icon(
                                  Icons.engineering,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (data.docs[index]['isAvailable'] == true) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: TextBold(
                                                  text:
                                                      'Vehicle on Maintenance?',
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              actions: <Widget>[
                                                MaterialButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: TextBold(
                                                      text: 'Close',
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                MaterialButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Cars')
                                                        .doc(
                                                            data.docs[index].id)
                                                        .update({
                                                      'isAvailable': false
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: TextBold(
                                                      text: 'Continue',
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: TextBold(
                                                  text: 'Vehicle ready to use?',
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              actions: <Widget>[
                                                MaterialButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: TextBold(
                                                      text: 'Close',
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                MaterialButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Cars')
                                                        .doc(
                                                            data.docs[index].id)
                                                        .update({
                                                      'isAvailable': true
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: TextBold(
                                                      text: 'Continue',
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ));
                                  }
                                })
                            : const SizedBox(),
                        body: Card(
                          elevation: 20,
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Image.network(
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                          'https://www.pngitem.com/pimgs/m/287-2876158_not-available-hd-png-download.png');
                                    },
                                    cars[index].imageUrl,
                                    height: 150,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextBold(
                                      text: data.docs[index]['model'],
                                      fontSize: 18,
                                      color: Colors.black),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBold(
                                      text:
                                          'Plate Number: ${data.docs[index]['plateNumber']}',
                                      fontSize: 12,
                                      color: Colors.black),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBold(
                                      text: 'Year: ${data.docs[index]['year']}',
                                      fontSize: 12,
                                      color: Colors.black),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBold(
                                      text:
                                          'Made by: ${data.docs[index]['maker']}',
                                      fontSize: 12,
                                      color: Colors.black),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextBold(
                                      text: data.docs[index]['isAvailable'] ==
                                              true
                                          ? 'Status: Available'
                                          : 'Status: Not Available',
                                      fontSize: 18,
                                      color: Colors.green),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
