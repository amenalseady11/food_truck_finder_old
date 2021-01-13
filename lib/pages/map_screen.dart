import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  List<Marker> markers = <Marker>[];

  CameraPosition myLocation = CameraPosition(
    target: LatLng(37, -122),
    zoom: 11,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        compassEnabled: true,
        buildingsEnabled: true,
        initialCameraPosition: myLocation,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: Set<Marker>.of(markers),
      ),
    );
  }
}
