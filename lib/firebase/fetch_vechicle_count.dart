// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'initializer.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class VehicleDataFetcher extends StatefulWidget {
  const VehicleDataFetcher({super.key});

  @override
  State<VehicleDataFetcher> createState() => _VehicleDataFetcherState();
}

String carCount1 = '';
class _VehicleDataFetcherState extends State<VehicleDataFetcher> {
  
  late MapboxMapController mapController;
  LocationData? currentLocation;
  late Location location;
  Symbol? currentSymbol;
  // use "count1" for Mapbox 
  int count1 = 0;
  
  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }


  Future<void> _getCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();
      _updateLocationOnMap();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

void _updateLocationOnMap() async {
  if (currentLocation?.latitude != null && currentLocation?.longitude != null) {
    final double? lat = currentLocation?.latitude;
    final double? lng = currentLocation?.longitude;
  
    mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(lat!, lng!),
      ),
    );

    if (currentSymbol != null) {
      mapController.removeSymbol(currentSymbol!);
    }

    // Add a marker at the current location
    currentSymbol = await mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(lat, lng),
        iconImage: 'car-15',
        iconSize: 2,
      ),
    );
  }
}


  @override
  void initState() {
    super.initState();
    activateListener();
    location = Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        this.currentLocation = currentLocation;
        _updateLocationOnMap();
      });
    });
  }

  void activateListener() {
    ref.child('/').onValue.listen((event) {
      // get a snapshot of the event
      final dynamic snapshotValue = event.snapshot.value;

      // check for event null
      if (snapshotValue == null) {
        if (kDebugMode) {
          print("Snapshot is null, check for Database reference");
        }
      } else {
          try {
            final String description = snapshotValue.toString();
            count1 = int.parse(description);

            setState(() 
              {
                carCount1 = description;
                if (kDebugMode) {
                  print(carCount1);
                }
                setState(() {});
              }
            );
          } catch (e) {
            if (kDebugMode) {
              print('Error parsing integer: $e');
            }
          }
        }
      }
    );
  }

  Color _getColor() {
    if (count1 >=3 ) {
      return Colors.red;
    } else if (count1 == 2) {
      return Colors.yellow;
    } else if(count1 < 2){
      return Colors.green;
    } else {
      return Colors.green;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          MapboxMap(
            accessToken: "pk.eyJ1IjoiYS1hZGl0eWEwMDciLCJhIjoiY2x1d3FnemkyMGdyMDJrcXJ4eWFoNzNzcCJ9.RTnlwCsLzU7g9vYkQ442GQ",
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(45.5231, -122.6765),
              zoom: 20.0,
            ),
          ),
          Positioned(
            top: size.height * 0.03,
            right: 20.0,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10.0),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(height: 10.0),
                FloatingActionButton(
                  onPressed: _getCurrentLocation,
                  child: const Icon(Icons.location_on),
                ),
              ],
            ),
          ),
          Positioned(
            top: 80.0,
            left: 20.0,
            child: Container(
              width: 80,
              height: 80,
              color: _getColor(),
            )
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: CoordinatesWidget(
              latitude: currentLocation?.latitude ?? 0.0,
              longitude: currentLocation?.longitude ?? 0.0,
            ),
          ),
        ],
      ),
    );
  }
}


class CoordinatesWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  const CoordinatesWidget({
    super.key, 
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latitude: $latitude',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Text(
            'Longitude: $longitude',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}


