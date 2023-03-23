import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addReq(name, address, vehicle, destination, dateTime) async {
  final docUser = FirebaseFirestore.instance
      .collection('Request')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'address': address,
    'vehicle': vehicle,
    'destination': destination,
    'status': 'Pending',
    'dateTime': dateTime
  };

  await docUser.set(json);
}
