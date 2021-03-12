import 'dart:collection';
import 'package:croco/AppLoginPage.dart';
import 'package:croco/Firebase.dart';
import 'package:croco/MainAppState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'Classes/Goods.dart';
import 'Classes/VendingMachine.dart';
import 'VendingMachineList.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'VendingMachinePage.dart';

class MapPage extends StatelessWidget {
  FlutterLocalNotificationsPlugin localNotif;

  void initState() {
    var androidInitialize =
        new AndroidInitializationSettings('ic_launcher.png');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

    localNotif = new FlutterLocalNotificationsPlugin();
    localNotif.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidInitialize = new AndroidInitializationSettings('@mipmap/logo');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

    localNotif = new FlutterLocalNotificationsPlugin();
    localNotif.initialize(initializationSettings);
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "There is a vending machine nearby!",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotif.show(0, "Feeling thirsty?",
        "There is a vending machine nearby!", generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    MainAppState state = context.watch<MainAppState>();
    return ChangeNotifierProvider(
        create: (_) => GoogleMapState(context, state),
        builder: (context, snapshot) {
          GoogleMapState mapState = context.watch<GoogleMapState>();
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppLoginPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.logout),
                ),
              ),
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
                        target: state.thisAppUser?.location,
                        zoom: 18.0,
                      ),
                      markers: mapState._markers,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            child: CupertinoButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                showSearch(
                                  context: context,
                                  delegate: DataSearch(),
                                );
                              },
                              child: CupertinoTextField(
                                enabled: false,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.all(16),
                                placeholderStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                                placeholder: 'Search',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/UserLocation.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/Destination.png');
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

class DataSearch extends SearchDelegate<String> {
  List<VendingMachine> availableVM = [];
  final recentGoods = [
    Goods("Pepsi", 'SK12443434', 9, 2.50, 'assets/images/Pepsi.png'),
    Goods("Sprite", 'SK12343434', 6, 2.50, 'assets/images/Sprite.jpg'),
  ];
  final goods = [
    Goods("Pepsi", 'SK12443434', 9, 2.50, 'assets/images/Pepsi.png'),
    Goods("Sprite", 'SK12343434', 6, 2.50, 'assets/images/Sprite.jpg'),
    Goods("A&W", 'SKSK12353434', 4, 3.50, 'assets/images/AnW.jpg'),
    Goods("Fanta Orange", 'SKSK12363434', 6, 2.50,
        'assets/images/Fanta Orange.png')
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    MainAppState appState = context.watch<MainAppState>();
    final suggestionList = query.isEmpty
        ? recentGoods
        : goods
            .where((p) => p.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
            onTap: () => {
                  for (VendingMachine i in appState.vendingMachines)
                    {
                      if (i.checkAvalibility(suggestionList[index]))
                        availableVM.add(i)
                    },
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VendingMachineList(
                          availableVM, suggestionList[index]),
                    ),
                  ),
                },
            leading: Icon(Icons.local_drink),
            title: Text(suggestionList[index].name)),
        itemCount: suggestionList.length);
  }
}

// bool isAvailable(List<VendingMachine> availableVM, Goods item){
//   availableVM.forEach((vm) )
// }

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
