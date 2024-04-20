import 'package:flutter/material.dart';
import '../../firebase/fetch_vechicle_count.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VehicleDataFetcher(),
    );
  }
}

// @TODO : implement Mapbox