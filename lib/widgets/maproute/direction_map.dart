import 'dart:async';

import 'package:Eletor/ui/loading/loading_view_model.dart';
import 'package:Eletor/utils/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class DirectionMap extends StatefulWidget{

  final GeoPoint geoPoint;
  DirectionMap({this.geoPoint});

  @override
  State<StatefulWidget> createState() => _DirectionMap();
}

class _DirectionMap extends State<DirectionMap>{

  static const double CAMERA_ZOOM = 10;
  static const double CAMERA_TILT = 20;
  static const double CAMERA_BEARING = 30;
  static const LatLng SOURCE_LOCATION = LatLng(14.8818,102.0207);


  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

  Set<Polyline>_polyline = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints _polylinePoints;

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  // Reference to Current and Destination Location
  LocationData currentLocation;
  LocationData destinationLocation;

  // Wrapper both LocationData
  Location location;

  Future _mapFuture = Future.delayed(Duration(milliseconds: 250), () => true);

  bool isWritePolyline = false;

  @override
  Widget build(BuildContext context) {


    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION
    );

    if(currentLocation!= null){
        initialCameraPosition = CameraPosition(
          bearing: CAMERA_BEARING,
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          target: LatLng(currentLocation.latitude,currentLocation.longitude));
    }

    return FutureBuilder(
        future: _mapFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          Completer<GoogleMapController> _controller = Completer();

          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child:  GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
              polylines: _polyline,
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) async{
                _controller.complete(controller);

                // EasyLoading.show();
                Provider.of<LoadingViewModel>(context,listen: false).showGoogleMapLoading();

                showPinsOnMap();
              },
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();
    _polylinePoints = PolylinePoints();

    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contain lat and long of current location data
      currentLocation = cLoc;
     updatePinOnMap();
    });

    // set the initial location
   setInitialLocation();
  }


  setInitialLocation() async {
    LocationData getLocation = await location.getLocation();
    setState(() {currentLocation = getLocation;});
  }

  showPinsOnMap() async {

    currentLocation = (currentLocation!=null)? currentLocation : await Location().getLocation();

    var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
    var destination = LatLng(widget.geoPoint.latitude,widget.geoPoint.longitude);

    setMarkers(pinPosition,destination);

    // set the route lines on the map from source to destination
    setPolyline();

  }

  setMarkers(LatLng pinPos, LatLng desPos){
    _markers.add(Marker(markerId: MarkerId("destination"), position: desPos,));

  }

  setPolyline() async {
    try{
      List<PointLatLng> result = await getRouteBetweenCoordinates();
      if(result.isNotEmpty){
        result.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      // EasyLoading.dismiss();
      Provider.of<LoadingViewModel>(context,listen: false).dismissGoogleMapLoading();

      setState(() {
        _polyline.add(Polyline(
            width: 5,
            polylineId: PolylineId("poly"),
            color: Colors.red,
            points: polylineCoordinates
        ));
      });
    }catch (error){
      isWritePolyline = false;
    }
  }


  Future<List<PointLatLng>> getRouteBetweenCoordinates() async {
    List<PointLatLng> result = await _polylinePoints
        .getRouteBetweenCoordinates(
        Values.mapApiKey,
        currentLocation.latitude,
        currentLocation.longitude,
        widget.geoPoint.latitude,
        widget.geoPoint.longitude);
    return result;
  }

  updatePinOnMap() async{
    // Create every time when Location changed
    CameraPosition cPosition = CameraPosition(
      tilt: CAMERA_TILT,
      zoom: CAMERA_ZOOM,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude,currentLocation.longitude),
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(() {
    // Update pin position on map
    //  var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);

      //
      // // trick is to remove the marker by markerId
      // _markers.removeWhere((m) => m.markerId.value == 'source');
      //
      // _markers.add(Marker(
      //   markerId: MarkerId("source"),
      //   position: pinPosition,
      // ));
    });
  }

  // Widget _loading(double width, double height) {
  //   return Container(
  //       margin: EdgeInsets.all(15),
  //       width: width,
  //       height: height,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.all(Radius.circular(8)),
  //         boxShadow: [
  //           BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 0.5)
  //         ],
  //       ));
  // }

  @override
  void dispose() {
    // EasyLoading.dismiss();
    super.dispose();
    Provider.of<LoadingViewModel>(context,listen: false).dismissGoogleMapLoading();
  }
}