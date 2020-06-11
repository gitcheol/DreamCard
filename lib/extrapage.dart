// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


List<int> fav_list=[1,2,3,4,5];

class Me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                semanticLabel: 'search',
              ),
              onPressed: () => Navigator.pop(context)
          ),
        ),
        body: Center(
          child: CarouselSlider(
            //height: 400.0,
            items: fav_list.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      //color: Colors.amber
                    ),
                    //child: Image.network(products[i].link),
                    child: Column(
                      children: <Widget>[
                        Image.network(""),
                        //_buildStack2(i)
                      ],

                    ),

                  );
                },
              );
            }).toList(),
            //autoPlay: false,



          )
        ),
      ),
    );
  }
}