import 'package:car_rental/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRecord extends StatelessWidget {
  final scrollController = ScrollController();
  AdminRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(250, 20, 250, 20),
      child: Container(
        width: 300,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: TextBold(
                    text: 'Data from January to December',
                    fontSize: 24,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Request')
                          .where('status', isEqualTo: 'Returned')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print('error');
                          return const Center(child: Text('Error'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            )),
                          );
                        }

                        final data = snapshot.requireData;
                        return SingleChildScrollView(
                          child: DataTable(columns: [
                            DataColumn(
                              label: TextBold(
                                  text: 'Personel',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextBold(
                                  text: 'Type of Vehicle',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextBold(
                                  text: 'Plate Number',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextBold(
                                  text: 'Total Distance\nTravelled',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextBold(
                                  text: 'Total Fuel\nUsed',
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextBold(
                                  text: 'Remarks',
                                  fontSize: 18,
                                  color: Colors.black),
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
                                      text: data.docs[i]['vehicleTemplate'],
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                DataCell(
                                  TextRegular(
                                      text: 'Not available',
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                DataCell(
                                  TextRegular(
                                      text: 'Not available',
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                DataCell(
                                  TextRegular(
                                      text: data.docs[i]['status'],
                                      fontSize: 14,
                                      color: Colors.green),
                                ),
                              ])
                          ]),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
