import 'package:flutter/material.dart';
import 'package:giftcard/giftcard.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Gift View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //list me iconat perkatese qe do builden tek navigation bar
  List _bootomItems = [
    {"icon": Icons.home},
    {"icon": Icons.mail},
    {"icon": Icons.share},
    {"icon": Icons.group},
    {'icon': Icons.shopping_basket},
  ];
  int _currentTab = 0;

  List data;
  Future<String> loadJsonDate() async {
    var jsonText = await rootBundle.loadString('assets/articles.json');
    setState(() {
      data = json.decode(jsonText);
      _loading=false;
    });
    print(jsonText);
  }

  bool _loading = true;

  @override
  void initState() {
    this.loadJsonDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
//shfaq navigator barin ne fund te widges
      bottomNavigationBar: _buildBottomNavigation(context),

      body: _buildBody(context),

      //
    );
  }

  //kjo ben ndertimin e button navigues poshte duke mare
  // me item['icon'] te gjitha iconat e dhena me larte teke lista _bootomItems
  //me ane te ciklit for ajo kap te gjitha iconat edhe i ben build poshte
  _buildBottomNavigation(BuildContext context) {
    var _items = <BottomNavigationBarItem>[];
    for (var item in _bootomItems) {
      _items.add(new BottomNavigationBarItem(
        icon: new Icon(
          item['icon'],
          color: Colors.black,
        ),
        title: new Text(''),
      ));
    }
// on tap
    return new BottomNavigationBar(
      currentIndex: _currentTab,
      items: _items,
      onTap: (index) {
        setState(() {
          _currentTab = index;
        });
      },
    );
  }
// kthen list viewn
  _buildBody(BuildContext context) {
if(_loading){
  return SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.yellow : Colors.black,
      ),
    );
  },
);
}

    return new ListView.builder(
      itemBuilder: (context, index) {
        return new Padding(
          padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          //krijimi i kartave
          child: ListGift(data:data[index],),
        );
      },
      itemCount: data.length,
    );
  }
}
