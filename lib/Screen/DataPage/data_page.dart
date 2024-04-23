import 'package:flutter/material.dart';
import '../../firebase/fetch_vechicle_count.dart';
import 'components/body.dart';

class DataPage extends StatelessWidget {
  final int vehicleCount;
  const DataPage({
     super.key, 
     required this.vehicleCount
   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Body(vehicleCount1: vehicleCount)
     );
  }
}
