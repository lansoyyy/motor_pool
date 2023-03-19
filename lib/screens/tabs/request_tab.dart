import 'package:car_rental/widgets/button_widget.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:car_rental/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class RequestTab extends StatefulWidget {
  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final destinationController = TextEditingController();

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

  String _selectedItem = 'Item 1';
  final List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5'
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
              Container(
                height: 300,
                width: 300,
                color: Colors.black,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                child: VerticalDivider(),
              ),
              SizedBox(
                height: 375,
                width: 300,
                child: Column(
                  children: [
                    Center(
                      child: TextBold(
                          text: 'Request vehicle now!',
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        label: 'Full name', controller: nameController),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        label: 'Address', controller: addressController),
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
                        label: 'Destination',
                        controller: destinationController),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                        label: 'Submit',
                        onPressed: (() {
                          _selectDateTime(context);
                        }))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
