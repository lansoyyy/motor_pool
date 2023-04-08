import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

import '../home_screen.dart';

class AdminMap extends StatefulWidget {
  const AdminMap({Key? key}) : super(key: key);

  @override
  State<AdminMap> createState() => AdminMapState();
}

class AdminMapState extends State<AdminMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xff6571E0),
        title: const Text(
          'Map of Vehicles',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'QBold',
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.509364, -0.128928),
          zoom: 9.2,
        ),
        children: const [
          // TileLayer(
          //   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', mapState: null, options: null, stream: null,
          // ),
        ],
      ),
    );
  }
}
