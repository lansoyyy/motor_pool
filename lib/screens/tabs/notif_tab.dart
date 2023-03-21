import 'package:car_rental/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NotifTab extends StatelessWidget {
  const NotifTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 100,
      child: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(450, 0, 450, 0),
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
                  text: 'Request for: Honda, Status: Approved',
                  fontSize: 15,
                  color: Colors.black),
              subtitle: TextRegular(
                  text: 'Status: Approved', fontSize: 12, color: Colors.blue),
              trailing: TextBold(
                  text: 'Date and Time', fontSize: 15, color: Colors.black),
            ),
          ),
        );
      }),
    );
  }
}
