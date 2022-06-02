import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:qr_scanner_sqlite/models/scan_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    CameraPosition initialPoint =
        CameraPosition(target: scan.getFormatLocation(), zoom: 17.5, tilt: 50);

    Set<Marker> markers = <Marker>{};

    markers.add(Marker(
        markerId: const MarkerId('geo-location'),
        position: scan.getFormatLocation()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () async {
              final GoogleMapController googleMapController =
                  await _controller.future;
              googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: scan.getFormatLocation(), zoom: 17.5, tilt: 50)));
            },
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
             
            }else{
              mapType = MapType.normal;

            }
             setState(() {});
          },
          child: const Icon(Icons.layers_rounded),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
