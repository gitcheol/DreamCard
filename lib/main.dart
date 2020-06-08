import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'restaurantlist.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'mypage.dart';
import 'search.dart';
import 'signin_page.dart';
import 'marker.dart';
import 'event.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions:<Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                semanticLabel: 'search',
              ),
              onPressed: () => Navigator.push(
                context,MaterialPageRoute(builder: (context)=>Search()),
              ),
            ),
          ],
          title: Text('DreamCard'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.fromLTRB(20, 120, 0, 0),
                child:
                //child: new CircleAvatar()),color: Colors.tealAccent,
                Text('Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
              ),
              ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home,
                    color : Colors.lightBlueAccent),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                  title: Text('Restaurant list'),
                  leading: Icon(Icons.location_city,
                      color : Colors.lightBlueAccent),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RestaurantList()),
                  )
              ),
              ListTile(
                  title: Text('Event'),
                  leading: Icon(Icons.event_available,
                      color : Colors.lightBlueAccent),
                  onTap: () => Navigator.pushNamed(context, '/Search')
              ),
              ListTile(
                  title: Text('My Page'),
                  leading: Icon(Icons.person,
                      color : Colors.lightBlueAccent),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPage()),
                  )
              ),
            ],
          ),
        ),
        body:MyAppState(),
      )
    );
  }
// #enddocregion build
}

class MyAppState extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppState> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
      ? MapType.satellite
      : MapType.normal;
      }
    );
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
        )   ,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(
          Icons.search,
          semanticLabel: 'search',
        ),
        onPressed: () => Navigator.push(
          context,MaterialPageRoute(builder: (context)=>Search()),
        ),
      ),
    );
  }
}

class SetAppBar extends StatelessWidget {
//  List<Marker> allMarkers = [];
  //mapController : manages camera function( position, animation, zoom)
//  GoogleMapController mapController;
//  //hanaro 36.082360, 129.398403
//  final LatLng _center = const LatLng(36.082360, 129.398403);
//
//
//  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:<Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () => Navigator.push(
              context,MaterialPageRoute(builder: (context)=>Search()),
            ),
          ),
        ],
        title: Text('DreamCard'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(20, 120, 0, 0),
              child:
              //child: new CircleAvatar()),color: Colors.tealAccent,
              Text('Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home,
                  color : Colors.lightBlueAccent),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                title: Text('Restaurant list'),
                leading: Icon(Icons.location_city,
                    color : Colors.lightBlueAccent),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestaurantList()),
                )
            ),
            ListTile(
                title: Text('Event'),
                leading: Icon(Icons.event_available,
                    color : Colors.lightBlueAccent),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Event()),
                )
            ),
            ListTile(
                title: Text('Login'),
                leading: Icon(Icons.assignment_ind ,
                    color : Colors.lightBlueAccent),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                )
            ),
            ListTile(
                title: Text('MyPage'),
                leading: Icon(Icons.person ,
                    color : Colors.lightBlueAccent),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPage()),
                )
            ),
            ListTile(
                title: Text('extrapage'),
                leading: Icon(Icons.add_box ,
                    color : Colors.lightBlueAccent),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Me()),
                )
            ),
          ],
        ),
      ),


//      body: GoogleMap(
//        onMapCreated: _onMapCreated,
//        initialCameraPosition: CameraPosition(
//          target: _center,
//          zoom: 15.0,
//        ),
//      ),
    );
  }

}





//webview
class MyWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  MyWebView({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}

