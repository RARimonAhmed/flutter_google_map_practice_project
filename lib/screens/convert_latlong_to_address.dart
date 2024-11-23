import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLongToAddress extends StatefulWidget {
  const ConvertLatLongToAddress({super.key});

  @override
  State<ConvertLatLongToAddress> createState() => _ConvertLatLongToAddress();
}

class _ConvertLatLongToAddress extends State<ConvertLatLongToAddress> {
  // late LocatitonGeocoder geocoder = LocatitonGeocoder("AIzaSyDN_z_Go2f7R7vkyGKY7CGmTvu423F8ECo");
  String coordinates = "";
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map Testing"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(coordinates),
              const SizedBox(height: 10,),
              TextField(

                decoration: InputDecoration(
                  hintText: "Enter place name",
                  prefixIcon: Icon(Icons.place_outlined),
                ),
                controller: textEditingController,
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () async {
                  List<Location> locations = await locationFromAddress(textEditingController.text);
                  if (locations.isNotEmpty) {
                  final location = locations.first;
                  setState(() {
                    coordinates = 'Latitude: ${location.latitude}, Longitude: ${location.longitude}';
                  });
                  }
                },
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Text("Convert"),
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
