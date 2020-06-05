import 'package:flutter/material.dart';
import 'main.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: MyApp(),

    );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var finaldate;
  var finaldate2;
  bool _isExpanded = true;
  bool value1=false;
  bool value2=false;
  bool value3=false;
  bool value4=false;
  bool value5=false;
  String sentence1='';
  String sentence2='';
  String sentence3='';
  String sentence4='';
  String sentence5='';
  String sen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ExpansionTile(
            title: Text('Filter                     select filter'),
            children: <Widget>[
              ListTile(
                leading: Checkbox(
                  value: value1,
                  onChanged: (bool) {
                    setState(() {
                      if(value1==true){
                        value1 =false;
                        sentence1='';
                      }
                      else{
                        value1=true;
                        sentence1="  No Kids Zone  ";
                      }
                    });
                  },
                ),
                title: Text("No Kids Zone"),
              ),
              ListTile(
                leading: Checkbox(
                  value: value2,
                  onChanged: (bool) {
                    setState(() {
                      if(value2==true){
                        value2 =false;
                        sentence2='';
                      }
                      else{
                        value2=true;
                        sentence2="  Pet-friendly  ";
                      }
                    });
                  },
                ),
                title: Text("Pet-friendly"),
              ),
              ListTile(
                leading: Checkbox(
                  value: value3,
                  onChanged: (bool) {
                    setState(() {
                      if(value3==true){
                        value3 =false;
                        sentence3='';
                      }
                      else{
                        value3=true;
                        sentence3="  Free breakfast  ";
                      }
                    });
                  },
                ),
                title: Text("Free breakfast"),
              ),
              ListTile(
                leading: Checkbox(
                  value: value4,
                  onChanged: (bool) {
                    setState(() {
                      if(value4==true){
                        value4 =false;
                        sentence4='';
                      }
                      else{
                        value4=true;
                        sentence4="  Free WiFi  ";
                      }
                    });
                  },
                ),
                title: Text("Free WiFi"),
              ),
              ListTile(
                leading: Checkbox(
                  value: value5,
                  onChanged: (bool) {
                    setState(() {
                      if(value5==true){
                        value5 =false;
                        sentence5='';
                      }
                      else{
                        value5=true;
                        sentence5="  Electir Car Charging  ";
                      }
                    });
                  },
                ),
                title: Text("Electir Car Charging"),
              ),
            ],
          ),

          //다음라인 여기부터
          Text(
            'Date',textAlign: TextAlign.left,
          ),

          RaisedButton(
            onPressed: callDatePicker,
            color: Colors.blueAccent,
            child:
            Text('Select : Check_in', style: TextStyle(color: Colors.white)),
          ),
          Text(
            finaldate.toString(),
          ),
          RaisedButton(
            onPressed: callDatePicker2,
            color: Colors.blueAccent,
            child:
            Text('Select : Check_out', style: TextStyle(color: Colors.white)),
          ),
          Text(
            finaldate2.toString(),
          ),
          RaisedButton(
            onPressed: _neverSatisfied,
            color: Colors.blueAccent,
            child:
            Text('Search', style: TextStyle(color: Colors.white)),
          ),


        ],

      ),
    );
  }




  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      finaldate = order;
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }
  void callDatePicker2() async {
    var order = await getDate();
    setState(() {
      finaldate2 = order;
    });
  }

  Future<DateTime> getDate2() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please check your choice:)'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
//                sentence1.toString()==null ? null:Text(sentence1.toString()),

                Text(sentence1+sentence2+sentence3+sentence4+sentence5),
                Text("Check in : "+finaldate.toString()),
                Text("Check out : "+finaldate2.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Search'),
              onPressed: () => Navigator.push(
                context,MaterialPageRoute(builder: (context)=>SetAppBar()),
              ),
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }






}







