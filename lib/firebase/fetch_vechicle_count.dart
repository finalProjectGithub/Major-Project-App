// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Screen/DataPage/data_page.dart';
import 'initializer.dart';

class VehicleDataFetcher extends StatefulWidget {
  const VehicleDataFetcher({super.key});

  @override
  State<VehicleDataFetcher> createState() => _VehicleDataFetcherState();
}

String carCount1 = '';
class _VehicleDataFetcherState extends State<VehicleDataFetcher> {
  
  // use "count1" for Mapbox 
  int count1 = 0;

  int returnVehicleCount() {
    return count1;
  }

  

  @override
  void initState() {
    super.initState();
    activateListener();
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataPage(
        vehicleCount: int.parse(carCount1)
      )
    );
  }
}