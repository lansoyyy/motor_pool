import 'package:car_rental/widgets/button_widget.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(350, 20, 350, 20),
      child: Container(
        width: 300,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: TextBold(
                  text: 'List of Request', fontSize: 24, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Request')
                      .where('status', isEqualTo: 'Pending')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print('error');
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
                    return DataTable(columns: [
                      DataColumn(
                        label: TextBold(
                            text: 'Name', fontSize: 18, color: Colors.black),
                      ),
                      DataColumn(
                        label: TextBold(
                            text: 'Vehicle', fontSize: 18, color: Colors.black),
                      ),
                      DataColumn(
                        label: TextBold(
                            text: 'Destination',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      DataColumn(
                        label: TextBold(
                            text: '', fontSize: 18, color: Colors.black),
                      ),
                    ], rows: [
                      for (int i = 0; i < data.docs.length; i++)
                        DataRow(cells: [
                          DataCell(
                            TextRegular(
                                text: data.docs[i]['name'],
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          DataCell(
                            TextRegular(
                                text: data.docs[i]['vehicle'],
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          DataCell(
                            TextRegular(
                                text: data.docs[i]['destination'],
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          DataCell(
                            Row(
                              children: [
                                ButtonWidget(
                                    width: 150,
                                    height: 40,
                                    fontSize: 12,
                                    color: Colors.green,
                                    label: 'Approve',
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Request')
                                          .doc(data.docs[i].id)
                                          .update({'status': 'Approved'});
                                    }),
                                const SizedBox(
                                  width: 10,
                                ),
                                ButtonWidget(
                                    width: 150,
                                    height: 40,
                                    fontSize: 12,
                                    color: Colors.red,
                                    label: 'Decline',
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Request')
                                          .doc(data.docs[i].id)
                                          .update({'status': 'Declined'});
                                    })
                              ],
                            ),
                          ),
                        ])
                    ]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
