import 'dart:convert';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/globals.dart' as globals;

class GeneralController extends GetxController {
  Future<dynamic> escanearCodigoBarras() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancelar', true, ScanMode.BARCODE);

    barcodeScanRes = barcodeScanRes.replaceAll(new RegExp(r'[A-Za-z]'), '');

    if (barcodeScanRes == '-1') {
      return {'msg': 'canceled'};
    } else {
      List product = globals.products
          .where((element) => element['barcode'] == barcodeScanRes)
          .toList();

      if (product.length > 0) {
        if (product[0]['imageUrl'] != null) {
          var uri =
              globals.api + '/getImageByUrl?url=' + product[0]['imageUrl'];

          var url = Uri.parse(uri);

          http.Response response = await http.get(url);

          String jsonsDataString = response.body.toString();
          print("jsonsDataString -->>> $jsonsDataString");

          product[0]['imageBase64'] = jsonsDataString;
          return {'msg': 'success', 'value': product[0]};
        } else {
          return {'msg': 'success', 'value': product[0]};
        }
      } else {
        return {'msg': 'not_found', 'barcode': barcodeScanRes};
      }
    }
  }

  Future<void> updateAllProducts() async {
    var uri = globals.api + '/getAllProducts';

    var url = Uri.parse(uri);

    http.Response response = await http.get(url);

    String jsonsDataString = response.body.toString();
    // print("jsonsDataString -->>> $jsonsDataString");

    var parsedJson = json.decode(jsonsDataString);

    globals.products = parsedJson;
    print('UPDATED ALL PRODUCTS');

    print(globals.products.length);

    return;
  }
}
