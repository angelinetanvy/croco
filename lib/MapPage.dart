import 'dart:collection';
import 'dart:math';

import 'package:croco/Classes/AppUsers.dart';
import 'package:croco/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'Classes/Goods.dart';
import 'Classes/VendingMachine.dart';
import 'VendingMachinePage.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainAppState state = context.watch<MainAppState>();
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
        create: (_) => GoogleMapState(context, state.vendingMachines),
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
                      onMapCreated: mapState._onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: state.thisAppUser.location,
                        zoom: 18.0,
                      ),
                      markers: mapState._markers,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 15,
                    left: 15,
                    child: Card(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              splashColor: Colors.grey,
                              icon: Icon(Icons.menu),
                              onPressed: () async {
                                Prediction p = await PlacesAutocomplete.show(
                                    context: context, apiKey: kGoogleApiKey);
                                displayPrediction(p);
                              },
                            ),
                            Expanded(
                              child: TextField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.go,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  hintText: "Search...",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.pink,
                                child: Text('YL'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }
}

class GoogleMapState with ChangeNotifier {
  BuildContext context;
  GoogleMapController mapController;
  Set<Marker> _markers = HashSet<Marker>();
  List<VendingMachine> vendingMachines;

  GoogleMapState(this.context, this.vendingMachines);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    vendingMachines.forEach((VendingMachine vendingMachine) {
      _markers.add(
        Marker(
          markerId: MarkerId(Random.secure().nextInt(10).toString()),
          position: vendingMachine.coor,
          infoWindow: InfoWindow(
            title: vendingMachine.name,
            snippet: vendingMachine.distance.toString() + " m",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VendingMachinePage(vendingMachine),
              ),
            ),
          ),
        ),
      );
    });
    notifyListeners();
  }
}
