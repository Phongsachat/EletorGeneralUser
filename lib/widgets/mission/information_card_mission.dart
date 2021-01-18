import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future _mapFuture = Future.delayed(Duration(milliseconds: 250), () => true);

Widget googleMap(GeoPoint _geoPoint,String markerId) {
  return FutureBuilder(
      future: _mapFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        Completer<GoogleMapController> _controller = Completer();

        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(_geoPoint.latitude, _geoPoint.longitude),
                  zoom: 16),
              markers: Set.from(setMark(_geoPoint.latitude,_geoPoint.longitude,markerId)),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
        );
      });
}

Widget googleMapRoute(GeoPoint _geoPoint,String markerId){
  return FutureBuilder(
      future: _mapFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        Completer<GoogleMapController> _controller = Completer();

        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(_geoPoint.latitude, _geoPoint.longitude),
                  zoom: 16),
              markers: Set.from(setMark(_geoPoint.latitude,_geoPoint.longitude,markerId)),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
        );
      });
}

List<Marker> setMark(double lat,double lng,String markerId){
  List<Marker> _myMarker = List<Marker>();
  _myMarker.add(Marker(
      markerId: MarkerId(markerId),
      position: LatLng(lat, lng),
      draggable: true,
      onDragEnd: (dragEndPosition) {print(dragEndPosition);}));

  return _myMarker;
}
