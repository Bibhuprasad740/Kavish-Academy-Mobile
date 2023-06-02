import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapbox'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5074, 0.1278),
          zoom: 13.0,
        ),
        layers: [
          // MapboxLayer(
          //   accessToken: 'YOUR_MAPBOX_ACCESS_TOKEN',
          //   style: 'mapbox://styles/mapbox/streets-v11',
          // ),
        ],
      ),
    );
  }
}
