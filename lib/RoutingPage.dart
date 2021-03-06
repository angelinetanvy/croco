import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class RoutingPage extends StatefulWidget {
  final LatLng start;
  final LatLng end;
  RoutingPage(this.start, this.end);

  @override
  State<StatefulWidget> createState() => RoutingPageState();
}

class RoutingPageState extends State<RoutingPage> {
  String googleAPIKey = "AIzaSyCQm8NvMYXqOGgd-_tD-wNlmFq0CU9H7z4";
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/UserLocation.png',
    );
    destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/destination_map_marker.png',
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  setPolylines() async {
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
      googleAPIKey,
      widget.start.latitude,
      widget.start.longitude,
      widget.end.latitude,
      widget.end.longitude,
    );
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);
      _polylines.add(polyline);
    });
  }

  void setMapPins() {
    setState(
      () {
        _markers.add(
          Marker(
            markerId: MarkerId('sourcePin'),
            position: widget.start,
            icon: sourceIcon,
          ),
        );
        _markers.add(
          Marker(
            markerId: MarkerId('destPin'),
            position: widget.end,
            icon: destinationIcon,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: widget.start);
    return GoogleMap(
      myLocationEnabled: true,
      compassEnabled: true,
      tiltGesturesEnabled: false,
      markers: _markers,
      polylines: _polylines,
      mapType: MapType.normal,
      initialCameraPosition: initialLocation,
      onMapCreated: onMapCreated,
    );
  }
}
