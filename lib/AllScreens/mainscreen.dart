import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MainScreen extends StatefulWidget
{
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  //String searchAddr;
  Position currentPosition;
  var geoLocator = Geolocator();

  void locatePosition() async   //current location
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  //static initial camera Position
  static final CameraPosition _ictTower = CameraPosition(
    target: LatLng(23.778748, 90.374724),
    zoom: 14.4746,
  );


  // //Create a map of markers which will store our fetched markers
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //
  // //Make a call to populateClients() from the initState()
  // @override
  // void initState() {
  //   super.initState();
  //   getMarkerData();
  // }
  //
  // //fetching the markers from the firestore
  // getMarkerData() {
  //   FirebaseFirestore.instance.collection('markers').getDocuments().then((docs) {
  //     if (docs.documents.isNotEmpty) {
  //       for (int i = 0; i < docs.documents.length; i++) {
  //         //clients.add(docs.documents[i].data);
  //         initMarker(docs.documents[i].markers, docs.documents[i].documentID);
  //       }
  //     }
  //   });
  // }
  //
  // //creates a marker from the fetched data and adds it to the map of markers
  // void initMarker(client, markerRef) {
  //   var markerIDVal = markerRef;
  //   final MarkerId markerId = MarkerId(markerIDVal);
  //
  //   //new marker
  //   final Marker marker = Marker(
  //     position:
  //     LatLng(client['coords'].latitude, client['coords'].longitude),
  //     infoWindow: InfoWindow(title: 'Mecha Garage', snippet: client['name']),
  //     markerId: markerId,
  //   );
  //
  //   setState(() {
  //     // adding a new marker to map
  //     markers[markerId] = marker;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            //markers: Set<Marker>.of(markers.values),
            myLocationButtonEnabled: true,
            initialCameraPosition: _ictTower,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locatePosition();
            },
          ),
          // Positioned(
          //   top: 30.0,
          //   right: 15.0,
          //   left: 15.0,
          //   child: Container(
          //     height: 50.0,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.0),
          //       color: Colors.white
          //     ),
          //     child: TextField(
          //       decoration: InputDecoration(
          //         hintText: 'Enter Area',
          //         border: InputBorder.none,
          //         contentPadding: EdgeInsets.only(left: 15.0,top: 15.0),
          //         suffixIcon: IconButton(
          //           icon: Icon(Icons.search),
          //           onPressed: () {},
          //           iconSize: 30.0,
          //         )
          //       ),
          //       onChanged: (val) {
          //         setState(() {
          //           searchAddr = val;
          //         });
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
  // searchandNavigate() {
  //   Geolocator().placemarkFromAddress(searchAddr).then((result) {
  //     newGoogleMapController.animateCamera(cameraUpdate.CameraPosition(comeraPosition))
  //   });
  // }
}
