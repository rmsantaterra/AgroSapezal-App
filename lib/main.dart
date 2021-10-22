import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcodescanner_example/pages/home_page.dart';
import 'package:get/get.dart';
import 'controller/general_controller.dart';
import 'utils/globals.dart' as globals;

void main() {
  runApp(MyApp());

  GeneralController().updateAllProducts();
  Timer.periodic(new Duration(minutes: globals.timeGetAllProducts), (timer) {
    GeneralController().updateAllProducts();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
      ],
    );
  }
}
