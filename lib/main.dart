import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mytv/detail.dart';
import 'package:mytv/detail_bingings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  String code = '';
  CancelableOperation cancellableOperation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    try {
      Position position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _getAddressFromLatLng(position: position);
    } catch (e) {}
  }

  _getAddressFromLatLng({Position position}) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      debugPrint('wkwkw ' + place.street + place.administrativeArea);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> fromCancelable(Future<dynamic> future) async {
    cancellableOperation?.cancel();
    cancellableOperation = CancelableOperation.fromFuture(future, onCancel: () {
      print('Operation Cancelled');
    });
    return cancellableOperation.value;
  }

  Future<dynamic> getTranslation(String query) async {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return "$query";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$code',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              children: List.generate(
                10,
                (index) => RaisedButton(
                    child: Text(index.toString()),
                    focusColor: Colors.green,
                    onPressed: () {
                      setState(() {
                        code = code + index.toString();
                      });
                    }),
              ),
            ),
            RaisedButton(
                child: Text('Delete'),
                focusColor: Colors.red,
                onPressed: () {
                  if (code.isNotEmpty) {
                    if ((code != null) && (code.length > 0)) {
                      setState(() {
                        code = code.substring(0, code.length - 1);
                      });
                    }
                  }
                }),
            RaisedButton(
                focusColor: Colors.red,
                onPressed: () {
                  fromCancelable(getTranslation("biji")).then((value) {
                    print("Then called: $value");
                  });
                }),
            RaisedButton(
                focusColor: Colors.yellow,
                onPressed: () {
                  fromCancelable(getTranslation("wkwkw")).then((value) {
                    print("Then called: $value");
                  });
                }),
            RaisedButton(
                color: Colors.red,
                onPressed: () {
                  Get.to(Detail(), binding: DetailBinding());
                }),
          ],
        ),
      ),
      // floatingActionButton: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     FloatingActionButton(
      //       focusColor: Colors.green,
      //       onPressed: _incrementCounter,
      //       tooltip: 'Increment',
      //       child: Icon(Icons.add),
      //     ),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     FloatingActionButton(
      //       focusColor: Colors.red,
      //       onPressed: _decrementCounter,
      //       tooltip: 'Increment',
      //       child: Icon(Icons.remove),
      //     ),
      //   ],
      // )
    );
  }
}
