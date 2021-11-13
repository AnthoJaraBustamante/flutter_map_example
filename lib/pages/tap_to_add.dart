import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

import '../widgets/drawer.dart';

class TapToAddPage extends StatefulWidget {
  static const String route = '/tap';

  @override
  State<StatefulWidget> createState() {
    return TapToAddPageState();
  }
}

class TapToAddPageState extends State<TapToAddPage> {
  List<LatLng> tappedPoints = [];

  @override
  Widget build(BuildContext context) {
    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => Container(
          child: CachedNetworkImage(
            imageUrl:
                'https://rodmensoft.com/wp-content/uploads/2020/12/Logo_Blanco.png',
            width: 80.0,
            height: 80.0,
            fit: BoxFit.fill,
            
            progressIndicatorBuilder: (
              BuildContext context,
              String url,
              DownloadProgress downloadProgress,
            ) =>
                Container(
              color: Colors.transparent,
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 8,
                value: downloadProgress.progress ?? 1.0,
              ),
            ),
            errorWidget: (BuildContext context, String url, dynamic error) =>
                Icon(
              Icons.error,
              size: 32,
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Tap to add pins')),
      drawer: buildDrawer(context, TapToAddPage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('Tap to add pins'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: LatLng(-16.3641, -71.5206),
                    zoom: 13.0,
                    onTap: _handleTap),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      tappedPoints.add(latlng);
    });
  }
}
