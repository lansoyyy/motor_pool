import 'package:car_rental/widgets/button_widget.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:car_rental/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/form_into_dialog.dart';

class VehicleOutTab extends StatefulWidget {
  const VehicleOutTab({super.key});

  @override
  State<VehicleOutTab> createState() => _VehicleOutTabState();
}

class _VehicleOutTabState extends State<VehicleOutTab> {
  final scrollController = ScrollController();

  int dropValue = 0;

  String newVehicle = '';

  String newPlateNumber = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(350, 20, 350, 20),
      child: Container(
        width: 500,
        color: Colors.white.withOpacity(0.8),
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
                          .where('status', isEqualTo: 'Approved')
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
                        return DataTable(columns: [
                          DataColumn(
                            label: TextBold(
                                text: '', fontSize: 18, color: Colors.black),
                          ),
                          DataColumn(
                            label: TextBold(
                                text: 'Organization',
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          DataColumn(
                            label: TextBold(
                                text: 'Name',
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          DataColumn(
                            label: TextBold(
                                text: 'Vehicle',
                                fontSize: 18,
                                color: Colors.black),
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
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return VehicleRequestDialog(
                                              pass: data.docs[i]
                                                  ['numberOfPassengers'],
                                              file: data.docs[i]['file'] ?? '',
                                              name: data.docs[i]['name'],
                                              contactNumber: data.docs[i]
                                                  ['contactNumber'],
                                              organizationName: data.docs[i]
                                                  ['organization'],
                                              vehicleType: data.docs[i]
                                                  ['vehicle'],
                                              vehicleTemplateNumber: data
                                                  .docs[i]['vehicleTemplate'],
                                              purposeOfTravel: data.docs[i]
                                                  ['purposeOfTravel'],
                                              dateOfTravel: data.docs[i]
                                                  ['dateOfTravel'],
                                              returnDateAndTime:
                                                  '${data.docs[i]['returnDate']} ${data.docs[i]['returnTime']}');
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              DataCell(
                                TextRegular(
                                    text: data.docs[i]['organization'],
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
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
                                        width: 120,
                                        height: 40,
                                        fontSize: 12,
                                        color: Colors.green,
                                        label: 'Mark as Returned',
                                        onPressed: () async {
                                          if (data.docs[i]['status'] !=
                                              'Approved') {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text:
                                                            'Return vehicle confirmation',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: TextRegular(
                                                        text:
                                                            'Are you sure you want to make this completed?',
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: TextRegular(
                                                                text: 'Close',
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Request')
                                                                  .doc(data
                                                                      .docs[i]
                                                                      .id)
                                                                  .update({
                                                                'status':
                                                                    'Completed'
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: TextBold(
                                                                text: 'Return',
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: TextBold(
                                                        text:
                                                            'Return vehicle confirmation',
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                    content: TextRegular(
                                                        text:
                                                            "The personal didn't mark the vehicle as returned, are you sure you wanted to mark it as completed?",
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: TextRegular(
                                                                text: 'Close',
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Request')
                                                                  .doc(data
                                                                      .docs[i]
                                                                      .id)
                                                                  .update({
                                                                'status':
                                                                    'Completed'
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: TextBold(
                                                                text: 'Return',
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                });
                                          }
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ButtonWidget(
                                        width: 120,
                                        height: 40,
                                        fontSize: 12,
                                        color: Colors.blue,
                                        label: 'Transfer Request',
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: TextBold(
                                                      text:
                                                          'Transfer request of vehicle confirmation',
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                  content: TextRegular(
                                                      text:
                                                          "Are you sure you wanted to transfer ${data.docs[i]['name']}'s request?",
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: TextRegular(
                                                              text: 'Close',
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);

                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: TextBold(
                                                                        text:
                                                                            'Select a vehicle',
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black),
                                                                    content: StatefulBuilder(builder:
                                                                        (context,
                                                                            setState) {
                                                                      return Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.white.withOpacity(0.75),
                                                                            border: Border.all(
                                                                              color: Colors.black,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        width:
                                                                            300,
                                                                        height:
                                                                            35,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 10,
                                                                              right: 10),
                                                                          child: StreamBuilder<QuerySnapshot>(
                                                                              stream: FirebaseFirestore.instance.collection('Cars').where('isAvailable', isEqualTo: true).snapshots(),
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
                                                                                return DropdownButton(
                                                                                    underline: Container(color: Colors.transparent),
                                                                                    value: dropValue,
                                                                                    onChanged: (value) {
                                                                                      setState(() {
                                                                                        dropValue = int.parse(value.toString());
                                                                                      });
                                                                                    },
                                                                                    items: [
                                                                                      for (int i = 0; i < data.docs.length; i++)
                                                                                        DropdownMenuItem(
                                                                                          onTap: () {
                                                                                            newVehicle = data.docs[i]['model'];
                                                                                            newPlateNumber = data.docs[i]['plateNumber'];
                                                                                          },
                                                                                          value: i,
                                                                                          child: Text(data.docs[i]['model']),
                                                                                        )
                                                                                    ]);
                                                                              }),
                                                                        ),
                                                                      );
                                                                    }),
                                                                    actions: <
                                                                        Widget>[
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.of(context).pop(true),
                                                                        child: TextBold(
                                                                            text:
                                                                                'Close',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 14),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          showToast(
                                                                              'Request transferred succesfully!');
                                                                          await FirebaseFirestore.instance.collection('Request').doc(data.docs[i].id).update({
                                                                            'vehicle':
                                                                                newVehicle,
                                                                            'vehicleTemplate':
                                                                                newPlateNumber
                                                                          });
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection(
                                                                                  'Cars')
                                                                              .doc(
                                                                                  newVehicle)
                                                                              .update({
                                                                            'isAvailable':
                                                                                false
                                                                          });
                                                                        },
                                                                        child: TextBold(
                                                                            text:
                                                                                'Continue',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          child: TextBold(
                                                              text: 'Continue',
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              });
                                        }),
                                  ],
                                ),
                              ),
                            ])
                        ]);
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
