import 'dart:collection';
import 'package:croco/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'Classes/VendingMachine.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'VendingMachinePage.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainAppState state = context.watch<MainAppState>();
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (_) => GoogleMapState(context, state),
        builder: (context, snapshot) {
          GoogleMapState mapState = context.watch<GoogleMapState>();
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      compassEnabled: true,
                      tiltGesturesEnabled: false,
                      polylines: mapState._polylines,
                      mapType: MapType.normal,
                      onMapCreated: mapState._onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: state.thisAppUser.location,
                        zoom: 18.0,
                      ),
                      markers: mapState._markers,
                    ),
                  ),
                  // FloatingSearchBar.builder(
                  //   trailing: CircleAvatar(
                  //     child: Text("YL")
                  //   )
                  //   ontap:(){}
                  //   decoration: InputDecoration.collapsed(
                  //   hintText: "Search...",
                  //   ),
                  // )
                ],
              ),
            ),
          );
        });
  }
}

class GoogleMapState with ChangeNotifier {
  String googleAPIKey = "AIzaSyCQm8NvMYXqOGgd-_tD-wNlmFq0CU9H7z4";
  BuildContext context;
  GoogleMapController mapController;
  Set<Marker> _markers = HashSet<Marker>();

  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  MainAppState appState;

  GoogleMapState(this.context, this.appState) {
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/UserLocation.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/Destination.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    appState.vendingMachines.forEach((VendingMachine vendingMachine) {
      _markers.add(
        Marker(
          markerId: MarkerId(vendingMachine.vendId),
          position: vendingMachine.coor,
          infoWindow: InfoWindow(
            title: vendingMachine.name,
            snippet: vendingMachine.distance.toString() + " m",
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VendingMachinePage(vendingMachine),
                ),
              ),
            },
          ),
        ),
      );
    });
    notifyListeners();
  }
}

// Positioned(
//                     top: 10,
//                     right: 15,
//                     left: 15,
//                     child: Card(
//                       elevation: 2,
//                       child: Container(
//                         color: Colors.white,
//                         child: Row(
//                           children: <Widget>[
//                             IconButton(
//                               splashColor: Colors.grey,
//                               icon: Icon(Icons.menu),
//                               onPressed: () {},
//                             ),
//                             Expanded(
//                               child: TextField(
//                                 cursorColor: Colors.black,
//                                 keyboardType: TextInputType.text,
//                                 textInputAction: TextInputAction.go,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   contentPadding:
//                                       EdgeInsets.symmetric(horizontal: 15),
//                                   hintText: "Search...",
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.deepPurple,
//                                 child: Text('RD'),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
