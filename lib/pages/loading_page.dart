import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

@override
Widget loadingWidget() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [SpinKitWave(color: Colors.blue[500])],
            ),
          )
        ],
      ),
    ),
  );
}
