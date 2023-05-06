import 'dart:typed_data';

import 'package:car_rental/services/add_req.dart';
import 'package:car_rental/widgets/button_widget.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:car_rental/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RequestTab extends StatefulWidget {
  const RequestTab({Key? key}) : super(key: key);

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final destinationController = TextEditingController();
  final organizationController = TextEditingController();
  final contactNumberController = TextEditingController();
  final purposeOfTravelController = TextEditingController();
  final vehicleTemplateController = TextEditingController();
  String dateOfTravel = '';
  String departureTime = '';
  String arrivalTime = '';
  String returnDate = '';
  String returnTime = '';

  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }

    final TimeOfDay? timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timePicked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          timePicked.hour,
          timePicked.minute,
        );
      });
    }
  }

  int dropValue = 0;

  String _selectedItem = 'Toyota Fortuner';
  String _selectedPlate = 'A2 L731';

  final List<String> _plates = [
    'A2 L731',
    'SLB 148',
    'S7D 456',
    'SJF 990',
    'SJF 961',
    'AO R157',
    'B9S 557',
    'A2Q 223',
    'SFP 162',
    'LAH 5540',
    'LAB 4405',
    'GAD 8218',
    'SBE 488'
  ];

  int index = 0;

  late bool pickedFile = false;

  late String fileName = '';

  late String fileUrl = '';

  late File imageFile;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 300, right: 300, top: 50, bottom: 50),
      child: Card(
        color: Colors.white.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 250,
          width: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 375,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: TextBold(
                            text: 'Motor Vehicle Use Request Form',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                          label:
                              'Name of Organization (Office/Department/Unit)',
                          controller: organizationController),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'Full name', controller: nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'Contact Number',
                          controller: contactNumberController),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'Purpose of Travel',
                          controller: purposeOfTravelController),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'Destination',
                          controller: destinationController),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (selectedDate != null) {
                            setState(() {
                              dateOfTravel =
                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRegular(
                                text: 'Date of Travel',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 35,
                              width: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText:
                                      dateOfTravel == '' ? '' : dateOfTravel,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                child: VerticalDivider(),
              ),
              SizedBox(
                height: 375,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (selectedTime != null) {
                            setState(() {
                              departureTime =
                                  "${selectedTime.hour}:${selectedTime.minute}";
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRegular(
                                text: 'Expected Departure Time',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 35,
                              width: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText:
                                      departureTime == '' ? '' : departureTime,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (selectedTime != null) {
                            setState(() {
                              arrivalTime =
                                  "${selectedTime.hour}:${selectedTime.minute}";
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRegular(
                                text: 'Expected Arrival Time',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 35,
                              width: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText:
                                      arrivalTime == '' ? '' : arrivalTime,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextRegular(
                            text: 'Vehicle', fontSize: 12, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.75),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        width: 300,
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Cars')
                                  .where('isAvailable', isEqualTo: true)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  print(snapshot.error);
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
                                return DropdownButton(
                                    underline:
                                        Container(color: Colors.transparent),
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
                                            _selectedItem =
                                                data.docs[i]['model'];
                                            _selectedPlate =
                                                data.docs[i]['plateNumber'];
                                            index = i;
                                          },
                                          value: i,
                                          child: Text(data.docs[i]['model']),
                                        )
                                    ]);
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (selectedDate != null) {
                            setState(() {
                              returnDate =
                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRegular(
                                text: 'Expected Return Date',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 35,
                              width: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: returnDate == '' ? '' : returnDate,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (selectedTime != null) {
                            setState(() {
                              returnTime =
                                  "${selectedTime.hour}:${selectedTime.minute}";
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRegular(
                                text: 'Expected Return Time',
                                fontSize: 12,
                                color: Colors.black),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 35,
                              width: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: returnTime == '' ? '' : returnTime,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextRegular(
                              text: pickedFile
                                  ? 'A file was attached'
                                  : 'No files attached',
                              fontSize: 12,
                              color: Colors.grey),
                          IconButton(
                            onPressed: () async {
                              List<int>? fileBytes;
                              String? fileName;

                              final result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                              );

                              if (result != null) {
                                setState(() {
                                  pickedFile = true;
                                  fileName = result.files.single.name;
                                  fileBytes = result.files.single.bytes!;
                                });
                              }

                              if (fileBytes != null && fileName != null) {
                                final bytes = Uint8List.fromList(fileBytes!);
                                await firebase_storage.FirebaseStorage.instance
                                    .ref('Files/$fileName')
                                    .putData(bytes);
                                fileUrl = await firebase_storage
                                    .FirebaseStorage.instance
                                    .ref('Files/$fileName')
                                    .getDownloadURL();
                              }
                            },
                            icon: const Icon(
                              Icons.attach_file_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Cars')
                              .where('isAvailable', isEqualTo: true)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error);
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

                            final data1 = snapshot.requireData;
                            return ButtonWidget(
                                label: 'Submit',
                                onPressed: (() async {
                                  // for (int i = 0; i < cars.length; i++) {
                                  //   await FirebaseFirestore.instance
                                  //       .collection('Cars')
                                  //       .doc(cars[i].model)
                                  //       .set({
                                  //     'model': cars[i].model,
                                  //     'maker': cars[i].make,
                                  //     'year': cars[i].year,
                                  //     'plateNumber': cars[i].plateNumber,
                                  //     'isAvailable': true
                                  //   });
                                  // }
                                  await FirebaseFirestore.instance
                                      .collection('Cars')
                                      .doc(data1.docs[index].id)
                                      .update({'isAvailable': false});
                                  addReq(
                                      nameController.text,
                                      addressController.text,
                                      destinationController.text,
                                      organizationController.text,
                                      contactNumberController.text,
                                      purposeOfTravelController.text,
                                      _selectedPlate,
                                      _selectedItem,
                                      dateOfTravel,
                                      departureTime,
                                      arrivalTime,
                                      returnDate,
                                      returnTime,
                                      fileUrl);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: TextBold(
                                            text: 'Request sent succesfully!',
                                            fontSize: 18,
                                            color: Colors.white)),
                                  );
                                  nameController.clear();
                                  destinationController.clear();
                                  addressController.clear();
                                  organizationController.clear();
                                  contactNumberController.clear();
                                  purposeOfTravelController.clear();
                                  vehicleTemplateController.clear();
                                }));
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
