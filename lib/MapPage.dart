import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Classes/Goods.dart';
import 'Classes/VendingMachine.dart';

class MapPage extends StatefulWidget {
  const MapPage();

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<Marker> _markers = HashSet<Marker>();
  final LatLng _center = const LatLng(3.064411, 101.600682);
  List<VendingMachine> vendingMachines;

  @override
  void initState() {
    super.initState();
    List<Goods> goods = [
      Goods("Coke", 0, 2, 2.50, 'assets/images/Coke.jpg'),
      Goods("Sprite", 0, 1, 2.50, 'assets/images/Sprite.jpg'),
      Goods("A&W", 0, 3, 3.50, 'assets/images/AnW.jpg')
    ];
    vendingMachines = [
      VendingMachine("Monash Hive Vending Machine", "0",
          LatLng(3.064431, 101.600582), goods, 10),
      VendingMachine("Monash SMR Vending Machine", "1",
          LatLng(3.061441, 101.600682), goods, 20),
      VendingMachine("Monash 9305 Vending Machine", "2",
          LatLng(3.061411, 101.600282), goods, 43),
      VendingMachine("Rock Cafe Vending Machine", "3",
          LatLng(3.062411, 101.603682), goods, 22),
      VendingMachine(
          "Croco Vending Machine", "4", LatLng(3.061888, 101.603888), goods, 30)
    ];
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(
      () {
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
                    builder: (context) => Scaffold(),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  markers: _markers,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  child: Container(
                    color: Colors.grey,
                    height: 50,
                    width: size.width,
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
