import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import 'restaurantlist.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'mypage.dart';
import 'search.dart';
//import 'signin_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  GoogleMapController mapController;
//
//  final LatLng _center = const LatLng(45.521563, -122.677433);
//
//  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SetAppBar()
    );
  }
}

class SetAppBar extends StatelessWidget {
  GoogleMapController mapController;
  //hanaro 36.082360, 129.398403
  final LatLng _center = const LatLng(36.082360, 129.398403);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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


      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
      ),
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

