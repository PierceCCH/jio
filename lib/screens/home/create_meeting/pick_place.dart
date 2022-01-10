import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:jio/credentials.dart';
import 'package:jio/models/user.dart';
import 'package:jio/screens/home/create_meeting/pick_time.dart';
import 'package:provider/provider.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: placesAPIKey);

class PickPlace extends StatefulWidget {
  @override
  _PickPlaceState createState() => _PickPlaceState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _PickPlaceState extends State<PickPlace> {
  GoogleMapController mapController;
  LatLng latLng;
  LatLng mapNEBounds = LatLng(1.43623, 104.0601);
  LatLng mapSWBounds = LatLng(1.19312, 103.5);
  final Set<Marker> _markers = {};
  bool isCollapsed = true;
  String address;

  Duration duration = const Duration(milliseconds: 100);
  double screenWidth;
  double screenHeight;
  final Color dashColor = Color(0xFF42A5F5);

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(1.3521, 103.8198),
    zoom: 11,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
        body: Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: initialLocation,
          cameraTargetBounds: new CameraTargetBounds(
            new LatLngBounds(northeast: mapNEBounds, southwest: mapSWBounds),
          ),
          markers: _markers,
        ),
        Positioned(
          top: 30.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black, spreadRadius: 1)]),
            child: FlatButton(
                onPressed: () async {
                  Prediction p = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: placesAPIKey,
                      language: "en",
                      mode: Mode.overlay,
                      components: [new Component(Component.country, "sg")]);
                  latLng =
                      await getLocationDetails(p, homeScaffoldKey.currentState);
                  searchandNavigate(latLng);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Enter Address",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(Icons.search)
                  ],
                )),
          ),
        ),
        locationCard(context),
      ],
    ));
  }

  Widget locationCard(context) {
    final user = Provider.of<Person>(context);
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? screenHeight : 0.5 * screenHeight,
      bottom: isCollapsed ? 0 : 0.05 * screenHeight,
      left: screenWidth * 0.05,
      right: screenWidth * 0.05,
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Meetup at',
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '$address',
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.1,
                  child: FlatButton(
                      color: Colors.transparent,
                      onPressed: () {
                        print(user);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickTime(address: address)),
                        );
                      },
                      child: Text(
                        "Pick a time",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(color: Colors.black, spreadRadius: 3),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.green, spreadRadius: 3),
          ],
        ),
        height: 70,
      ),
    );
  }

//moves camera to location given by chosen latlng
//adds a marker to location
  searchandNavigate(LatLng latLng) async {
    print("Moving camera");
    if (latLng == null) {
      return null;
    }

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 17.0)));

    setState(() {
      if (_markers != null) {
        _markers.removeWhere((item) => item.markerId == MarkerId("last"));
      }
      _markers.add(Marker(
        markerId: MarkerId("last"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    getAddressFromLatLng(latLng);
    print("Pointer moved to $latLng");
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

//gets address of chosen place through given latlng
  void getAddressFromLatLng(LatLng latLng) async {
    print("Getting address from LatLng......");
    double lat = latLng.latitude;
    double lng = latLng.longitude;
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(lat, lng);

    String country = placemark[0].locality;
    String postalCode = placemark[0].postalCode;
    String block = placemark[0].name;
    String road = placemark[0].thoroughfare;
    String place = "$block $road, $country $postalCode";

    print(place);
    setState(() {
      address = place;
    });
  }

//predicts places as user types in address
//returns latlng value if location is found
//brings up the locationcard if location is found
  Future<LatLng> getLocationDetails(
      Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      print("Getting location details");
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      if (isCollapsed == true) {
        isCollapsed = false;
      }

      print("isCollapsed: $isCollapsed");

      return LatLng(lat, lng);
    }
    return null;
  }
}
