import 'package:car_rental/widgets/button_widget.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({super.key});

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
              child: DataTable(columns: [
                DataColumn(
                  label:
                      TextBold(text: 'Name', fontSize: 18, color: Colors.black),
                ),
                DataColumn(
                  label: TextBold(
                      text: 'Vehicle', fontSize: 18, color: Colors.black),
                ),
                DataColumn(
                  label: TextBold(
                      text: 'Destination', fontSize: 18, color: Colors.black),
                ),
                DataColumn(
                  label: TextBold(text: '', fontSize: 18, color: Colors.black),
                ),
              ], rows: [
                DataRow(cells: [
                  DataCell(
                    TextRegular(
                        text: 'Lance Olana', fontSize: 14, color: Colors.grey),
                  ),
                  DataCell(
                    TextRegular(
                        text: 'Tesla Model X',
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                  DataCell(
                    TextRegular(
                        text: 'Cagayan De Oro City',
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
                            onPressed: () {}),
                        const SizedBox(
                          width: 10,
                        ),
                        ButtonWidget(
                            width: 150,
                            height: 40,
                            fontSize: 12,
                            color: Colors.red,
                            label: 'Decline',
                            onPressed: () {})
                      ],
                    ),
                  ),
                ])
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
