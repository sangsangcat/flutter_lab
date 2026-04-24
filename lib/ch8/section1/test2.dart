import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String? latitude;
  String? longitude;

  getGeoData() async {
    //퍼미션 체크..
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //퍼미션 조정 다이얼로그 띄우기..
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //dialog 에서 유저가 거부..
        return Future.error('permission denied');
      }
    }

    //위치 정보 획득..
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getGeoData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('geolocator test')),
        body: Column(
          children: [
            Text('latitude : $latitude'),
            Text('longitude : $longitude'),
          ],
        ),
      ),
    );
  }
}
