import 'package:car_rental/services/add_req.dart';
import 'package:car_rental/widgets/button_widget.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:car_rental/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

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

  String _selectedItem = 'Toyota Fortuner';

  final List<String> _items = [
    'Toyota Fortuner',
    'Kia Sportage',
    'Toyota Avanza',
    'Toyota Innova',
    'T-Hi-Ace Grandia',
    'T-Hi-Ace Commuter',
    'Mitsubishi L300',
    'Toyota Hilux',
    'T.T.FX. Revo SR',
    'Hino Truck Van',
    'Hino Bus New',
    'Hyundai County',
    'Willys Jeep'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 300, right: 300, top: 50, bottom: 50),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
                                text: 'Expecture Departure Time',
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
                                text: 'Expecture Arrival Time',
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
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        width: 300,
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButton<String>(
                            underline: Container(color: Colors.transparent),
                            value: _selectedItem,
                            onChanged: (value) {
                              setState(() {
                                _selectedItem = value!;
                              });
                            },
                            items: _items.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'Motor Vehicle Template Number',
                          controller: vehicleTemplateController),
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
                                text: 'Expecture Return Date',
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
                                text: 'Expecture Return Time',
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
                        height: 30,
                      ),
                      ButtonWidget(
                          label: 'Submit',
                          onPressed: (() {
                            addReq(
                                nameController.text,
                                addressController.text,
                                destinationController.text,
                                organizationController.text,
                                contactNumberController.text,
                                purposeOfTravelController.text,
                                vehicleTemplateController.text,
                                _selectedItem,
                                dateOfTravel,
                                departureTime,
                                arrivalTime,
                                returnDate,
                                returnTime);
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
                          }))
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
