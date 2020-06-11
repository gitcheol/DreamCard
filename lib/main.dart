//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rxdart/rxdart.dart';

import 'restaurantlist.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'mypage.dart';
import 'search.dart';
import 'signin_page.dart';
import 'event.dart';
import 'extrapage.dart';

void main() => runApp(MapHome());


class MapHome extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
// #enddocregion build
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(36.078730, 129.392920);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  GoogleMapController _mapController;
  TextEditingController _latitudeController, _longitudeController, name_con;


  Firestore _firestore = Firestore.instance;
  Geoflutterfire geo;
  Stream<List<DocumentSnapshot>> stream;
  var radius = BehaviorSubject<double>.seeded(1.0);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _latitudeController = TextEditingController();
    _longitudeController = TextEditingController();
    name_con = TextEditingController();

//    geo = Geoflutterfire();
//    GeoFirePoint center = geo.point(latitude: 36.078730, longitude: 129.392920);
//    stream = radius.switchMap((rad) {
//      var collectionReference = _firestore.collection('restaurant');
////          .where('name', isEqualTo: 'darshan');
//      return geo.collection(collectionRef: collectionReference).within(
//          center: center, radius: rad, field: 'location', strictMode: true);
//    });

  }





  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    }
    );
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
//    _controller.complete(controller);
    geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: 36.078730, longitude: 129.392920);
//    stream = radius.switchMap((rad) {
//      var collectionReference = _firestore.collection('restaurant');
////          .where('name', isEqualTo: 'darshan');
//      return geo.collection(collectionRef: collectionReference).within(
//          center: center, radius: rad, field: 'location', strictMode: true);
//    });

    var collectionReference = _firestore.collection('restaurant');
    stream = geo.collection(collectionRef: collectionReference).within(
        center: center, radius: 5, field: 'location', strictMode: true);  // 반경 조절 가능
    print("here");
    print(stream);
    setState(() {
      _mapController = controller;
//      _showHome();
      //start listening after map is created
      stream.listen((List<DocumentSnapshot> documentList) {
        print('llllllllllllllllllisten');
        _updateMarkers(documentList);
      });
    });
  }

  void _addMarker(double lat, double lng, String name, String phone, String url, int like) {
    double tmp = BitmapDescriptor.hueViolet;
    if(like > 0)
      tmp = BitmapDescriptor.hueRed;
    MarkerId id = MarkerId(lat.toString() + lng.toString());
    Marker _marker = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(tmp),
      infoWindow: InfoWindow(
          title: '$name',
          snippet: '$phone',
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MyWebView(
                  title: name,
                  selectedUrl: url,
                )));
          }),
    );
    setState(() {
      markers[id] = _marker;
    });
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
//    print("uuuuuuuuuuuuuu");
    print(documentList.length);
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint point = document.data['location']['geopoint'];
      String name = document.data['name'];
      String phone = document.data['phone_number'];
      String url = document.data['URL'];
      int like = document.data['like'];
      _addMarker(point.latitude, point.longitude,name,phone,url,like);
//      print("ppppppppppppppppppppp");
//      print(point.latitude);
    });
  }

  void _addPoint(double lat, double lng, String name) {
    GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
    _firestore
        .collection('restaurant').document(name)
        .setData({'name': 'random name', 'location': geoFirePoint.data}).then((_) {
      print('added ${geoFirePoint.hash} successfully');
    });
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
              context,MaterialPageRoute(builder: (context)=>SearchPage()),
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
                  MaterialPageRoute(builder: (context) => ProfilePage()),
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
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            mapType: _currentMapType,
            markers: Set<Marker>.of(markers.values),
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.lightBlueAccent,
                    child: const Icon(Icons.map, size: 36.0),
                  ),
                ],
              ),
            ),
          ),
        ],
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
          backgroundColor: Colors.lightBlueAccent,
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