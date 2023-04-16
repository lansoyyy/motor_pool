import 'package:car_rental/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdminRecord extends StatelessWidget {
  const AdminRecord({Key? key}) : super(key: key);

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
            SingleChildScrollView(
              child: DataTable(columns: [
                DataColumn(
                  label: TextBold(
                      text: 'Personel', fontSize: 18, color: Colors.black),
                ),
                DataColumn(
                  label: TextBold(
                      text: 'Type of Vehicle',
                      fontSize: 18,
                      color: Colors.black),
                ),
                DataColumn(
                  label: TextBold(
                      text: 'Plate Number', fontSize: 18, color: Colors.black),
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
                      text: 'Remarks', fontSize: 18, color: Colors.black),
                ),
              ], rows: [
                DataRow(cells: [
                  DataCell(
                    TextRegular(
                        text: 'John Doe', fontSize: 14, color: Colors.grey),
                  ),
                  DataCell(
                    TextRegular(
                        text: 'Tesla Model X',
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                  DataCell(
                    TextRegular(
                        text: '123456', fontSize: 14, color: Colors.grey),
                  ),
                  DataCell(
                    TextRegular(text: '23km', fontSize: 14, color: Colors.grey),
                  ),
                  DataCell(
                    TextRegular(
                        text: '5 liters', fontSize: 14, color: Colors.grey),
                  ),
                  DataCell(
                    TextRegular(
                        text: 'Done', fontSize: 14, color: Colors.green),
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
