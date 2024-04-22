import 'package:flutter/material.dart';

import 'map_box_widget.dart';

class Body extends StatelessWidget {
  final int vehicleCount1;
  const Body({super.key, required this.vehicleCount1});

  @override
  Widget build(BuildContext context) {
    return MapboxMapPage(vehicleCount: vehicleCount1,);
  }
}