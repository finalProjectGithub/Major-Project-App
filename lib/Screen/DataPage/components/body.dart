import 'package:app/Screen/DataPage/components/background.dart';
import 'package:app/firebase/fetch_vechicle_count.dart';
import 'package:flutter/material.dart';


class Body extends StatelessWidget {
  final int vehicleCount1;
  const Body({super.key, required this.vehicleCount1});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: VehicleDataFetcher()
    );
  }
}