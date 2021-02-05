import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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
  String _mapStyle;

  List<Marker> markers = <Marker>[];

  BitmapDescriptor pinLocationIconRed;
  BitmapDescriptor pinLocationIconGreen;

  void setCustomMapPin() async {
    pinLocationIconRed = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/marker_red_transp.png');
    pinLocationIconGreen = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/marker_green_transp.png');
  }

  @override
  void initState() {
    super.initState();
    //setCustomMapPin();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
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
              infoWindow: InfoWindow(
                title: item.name,
                snippet: item.cuisine,
              ),
              //icon: (item.status) ? pinLocationIconGreen : pinLocationIconRed,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  (item.status) ? 80 : 15),
              //icon: BitmapDescriptor.defaultMarkerWithHue(39.0),
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
        mapToolbarEnabled: false,
        initialCameraPosition: myLocation,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          //mapController.setMapStyle(_mapStyle);
        },
        markers: Set<Marker>.of(markers),
      ),
    );
  }
}
