import 'package:car_rental/widgets/form_into_dialog.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotifTab extends StatelessWidget {
  const NotifTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Request')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('dateTime')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return SizedBox(
            height: 250,
            width: 100,
            child: ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  final userData = data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(450, 0, 450, 0),
                    child: GestureDetector(
                      onTap: () {
                        if (data.docs[index]['status'] == 'Pending') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return VehicleRequestDialog(
                                    name: userData['name'],
                                    contactNumber: userData['contactNumber'],
                                    organizationName: userData['organization'],
                                    vehicleType: userData['vehicle'],
                                    vehicleTemplateNumber:
                                        userData['vehicleTemplate'],
                                    purposeOfTravel:
                                        userData['purposeOfTravel'],
                                    dateOfTravel: userData['dateOfTravel'],
                                    returnDateAndTime:
                                        '${userData['returnDate']} ${userData['returnTime']}');
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: TextBold(
                                      text: 'Return confirmation',
                                      fontSize: 18,
                                      color: Colors.black),
                                  content: TextRegular(
                                      text: 'Returned the vehicle?',
                                      fontSize: 14,
                                      color: Colors.black),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: TextRegular(
                                              text: 'Close',
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Request')
                                                .doc(data.docs[index].id)
                                                .update({'status': 'Returned'});
                                            Navigator.pop(context);
                                          },
                                          child: TextBold(
                                              text: 'Return',
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 20,
                        child: ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(
                            Icons.notifications,
                            color: Colors.blue,
                          ),
                          title: TextRegular(
                              text: 'Request for: ${userData['vehicle']}',
                              fontSize: 15,
                              color: Colors.black),
                          subtitle: TextRegular(
                              text: 'Status: ${userData['status']}',
                              fontSize: 12,
                              color: Colors.blue),
                          trailing: TextBold(
                              text: DateFormat.yMMMd()
                                  .add_jm()
                                  .format(userData['dateTime'].toDate()),
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
