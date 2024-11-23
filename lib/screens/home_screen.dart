import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_map_practice_project/screens/convert_latlong_to_address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(23.8041, 90.4152), zoom: 14);
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _marker = [];
  List<Marker> _list =  const [
    Marker(markerId: MarkerId("1"),position: LatLng(23.839784, 90.376036),infoWindow: InfoWindow(title: "My Current Location")),
    Marker(markerId: MarkerId("2"),position: LatLng(23.8298, 90.3636),infoWindow: InfoWindow(title: "Another Location")),
  ];

  @override
  void initState() {
    _marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.normal,
          myLocationEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on_outlined),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(23.8298, 90.3636),zoom: 14),
          ));
          setState(() {});
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ConvertLatLongToAddress()));
        },
      ),
    );
  }
}
