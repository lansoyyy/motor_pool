import 'package:car_rental/widgets/text_widget.dart';
import 'package:car_rental/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VehicleRequestDialog extends StatelessWidget {
  final String name;
  final String contactNumber;
  final String organizationName;
  final String vehicleType;
  final String vehicleTemplateNumber;
  final String purposeOfTravel;
  final String dateOfTravel;
  final String returnDateAndTime;
  final String file;

  const VehicleRequestDialog(
      {super.key,
      required this.name,
      required this.contactNumber,
      required this.organizationName,
      required this.vehicleType,
      required this.vehicleTemplateNumber,
      required this.purposeOfTravel,
      required this.dateOfTravel,
      required this.returnDateAndTime,
      required this.file});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Vehicle Request Information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildInfoRow(Icons.person, 'Name', name),
          _buildInfoRow(Icons.phone, 'Contact Number', contactNumber),
          _buildInfoRow(Icons.business, 'Organization', organizationName),
          _buildInfoRow(Icons.directions_car, 'Vehicle Type', vehicleType),
          _buildInfoRow(Icons.format_list_numbered, 'Template Number',
              vehicleTemplateNumber),
          _buildInfoRow(Icons.note, 'Purpose of Travel', purposeOfTravel),
          _buildInfoRow(Icons.date_range, 'Date of Travel', dateOfTravel),
          _buildInfoRow(
              Icons.timelapse, 'Return Date and Time', returnDateAndTime),
          file != ''
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextRegular(
                            text: 'A file as attached',
                            fontSize: 14,
                            color: Colors.grey),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await canLaunch(file)) {
                          await launch(file);
                        } else {
                          showToast('Cannot open file');
                        }
                      },
                      icon: const Icon(Icons.download),
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData iconData, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(iconData, color: Colors.blue),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(label, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4.0),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
