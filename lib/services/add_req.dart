import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addReq(
    name,
    address,
    destination,
    organization,
    contactNumber,
    purposeOfTravel,
    vehicleTemplate,
    vehicle,
    dateOfTravel,
    departureTime,
    arrivalTime,
    returnDate,
    returnTime,
    List file) async {
  final docUser = FirebaseFirestore.instance.collection('Request').doc();

  final json = {
    'name': name,
    'address': address,
    'vehicle': vehicle,
    'destination': destination,
    'organization': organization,
    'contactNumber': contactNumber,
    'purposeOfTravel': purposeOfTravel,
    'vehicleTemplate': vehicleTemplate,
    'dateOfTravel': dateOfTravel,
    'departureTime': departureTime,
    'arrivalTime': arrivalTime,
    'returnDate': returnDate,
    'returnTime': returnTime,
    'status': 'Pending',
    'dateTime': DateTime.now(),
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'km': 0,
    'file': file,
  };

  await docUser.set(json);
}
