import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/userlocation_model.dart';
import '../models/foodtruck_model.dart';
import '../colors.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final foodtrucks = Provider.of<List<FoodTruck>>(context);
    final userlocation = Provider.of<UserLocation>(context);

    CameraPosition myLocation = CameraPosition(
      target: LatLng(userlocation.latitude, userlocation.longitude),
      zoom: 11,
    );

    if (foodtrucks != null) {
      foodtrucks.forEach(
        (item) {
          markers.add(
            Marker(
              markerId: MarkerId(item.id),
              position: LatLng(item.latitude, item.longitude),
              infoWindow: InfoWindow(title: item.name, snippet: item.cuisine),
              icon: BitmapDescriptor.defaultMarkerWithHue((item.status)
                  ? BitmapDescriptor.hueGreen
                  : BitmapDescriptor.hueRed),
              onTap: () {},
            ),
          );
        },
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        rotateGesturesEnabled: false,
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
