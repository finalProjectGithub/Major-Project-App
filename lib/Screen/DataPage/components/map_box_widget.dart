import 'package:app/firebase/fetch_vechicle_count.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:math';


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

class ColorBlock extends StatefulWidget {
  @override
  _ColorBlockState createState() => _ColorBlockState();
}

class _ColorBlockState extends State<ColorBlock> {
  late Timer _timer;
  final _random = Random();
  int _GaadiSankhya = 0;

  @override
  void initState() {
    super.initState();
     setState(() {
        _GaadiSankhya = int.parse(carCount1); // Generate a random number between 0 and 30
      }); 
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Color _getColor() {
    if (_GaadiSankhya > 5) {
      return Colors.red;
    } else if (_GaadiSankhya < 5 && _GaadiSankhya >= 3) {
      return Colors.yellow;
    } else if(_GaadiSankhya < 3){
      return Colors.green;
    } else {
      return Colors.green;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      color: _getColor(),
    );
  }
}


class MapboxMapPage extends StatefulWidget {
  final vehicleCount;
  const MapboxMapPage({
    super.key, 
    required this.vehicleCount
  });

  @override
  // ignore: library_private_types_in_public_api
  _MapboxMapPageState createState() => _MapboxMapPageState();
}

class _MapboxMapPageState extends State<MapboxMapPage> {
  late MapboxMapController mapController;
  late LocationData currentLocation;
  late Location location;
  Symbol? currentSymbol;

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
    if (currentLocation != null) {
      final double lat = currentLocation.latitude ?? 0.0;
      final double lng = currentLocation.longitude ?? 0.0;
      
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(lat, lng),
        ),
      );

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
    location = Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        this.currentLocation = currentLocation;
        _updateLocationOnMap();
      });
    });
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
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 10.0),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: Icon(Icons.remove),
                ),
                SizedBox(height: 10.0),
                FloatingActionButton(
                  onPressed: _getCurrentLocation,
                  child: Icon(Icons.location_on),
                ),
              ],
            ),
          ),
          Positioned(
            top: 80.0,
            left: 20.0,
            child: ColorBlock(),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: CoordinatesWidget(
              latitude: currentLocation.latitude ?? 0.0,
              longitude: currentLocation.longitude ?? 0.0,
            ),
          ),
        ],
      ),
    );
  }
}