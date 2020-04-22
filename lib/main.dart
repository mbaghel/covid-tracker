import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'src/covidStats.dart' as covidStats;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Global Coronavirus Tracker",
      home: CovidMap(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.redAccent
      ),
    );
  }
}

class CovidMap extends StatefulWidget {
  @override
  _CovidMapState createState() => _CovidMapState();
}

class _CovidMapState extends State<CovidMap> {
  final Map<String, Marker> _markers = {};
  TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = _handlePress;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _handlePress() async {
    const url = 'https://github.com/ExpDev07/coronavirus-tracker-api';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final latestStats = await covidStats.getCovidStats();
    setState(() {
      _markers.clear();
      for (final location in latestStats.locations) {
        if (location.latest.confirmed > 0) {
          String title = location.country;
          if (location.province.isNotEmpty) {
            title = location.province + ", " + location.country;
          }
          final marker = Marker(
            markerId: MarkerId(location.id.toString()),
            position: LatLng(double.parse(location.coordinates.latitude),
                double.parse(location.coordinates.longitude)),
            infoWindow: InfoWindow(
                title: title,
                snippet: "Confirmed: ${location.latest
                    .confirmed}, Deaths: ${location.latest
                    .deaths}, Recovered: ${location.latest.recovered}"
            ),
          );
          _markers[location.id.toString()] = marker;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Coronavirus Tracker'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info_outline), onPressed: _pushInfo)
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }

  void _pushInfo() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('About The App'),
                ),
                body: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 2,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Global Coronavirus Tracker sources its data from coronavirus-tracker API: '
                      ),
                      TextSpan(
                          text: 'https://github.com/ExpDev07/coronavirus-tracker-api',
                        recognizer: _tapGestureRecognizer,
                        style: TextStyle(color: Colors.blue)
                      ),
                      TextSpan(
                        text: ', which grants use under the GNU General Public License v3.0.'
                      ),
                    ]
                  ),
                )
              );
            }
        )
    );
  }


}