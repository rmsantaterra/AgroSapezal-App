import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcodescanner_example/controller/general_controller.dart';
import 'package:flutter_barcodescanner_example/pages/productInfos.dart';
import 'package:get/get.dart';
import '../utils/globals.dart' as globals;

import 'bulkDogFoodCalc.dart';
import 'loading_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  bool _isLoading = false;

  HomePage() {
    Get.put(GeneralController());
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading && globals.products.length > 0) {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text("Agro Sapezal"),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      reloadProducts();
                    },
                    child: Icon(
                      Icons.refresh,
                      size: 26.0,
                    ),
                  )),
            ],
          ),
          body: SizedBox.expand(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          callScanScreen(context);
                        },
                        child: Container(
                          width: 250,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.white,
                              border: Border.all(color: Colors.blue.shade400)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.png',
                                width: 120,
                                height: 120,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Buscar por Cód. Barras',
                                    style: TextStyle(fontSize: 20),
                                  ))
                            ],
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    GestureDetector(
                        onTap: () {
                          callDogFoodCalculator(context);
                        },
                        child: Container(
                          width: 250,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.white,
                              border: Border.all(color: Colors.blue.shade400)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/apple-calculator.png',
                                width: 120,
                                height: 120,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Valor Ração a Granel',
                                    style: TextStyle(fontSize: 20),
                                  ))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ));
    } else {
      Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          globals.products = globals.products;
        });
      });
      return loadingWidget();
    }
  }

  callScanScreen(context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = true;
      });
    });

    Get.put(GeneralController().escanearCodigoBarras().then((dynamic ret) {
      if (ret['msg'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return ProductInfos(ret['value']);
          }),
        );
      } else if (ret['msg'] == 'not_found') {
        String title = 'Produto não cadatrado!';
        String text = ret['barcode'] + ' não localizado.';
        _showDialog(context, title, text);
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _isLoading = false;
        });
      });
    }));
  }

  reloadProducts() {
    setState(() {
      _isLoading = true;
    });

    GeneralController().updateAllProducts().then((value) {
      String title = 'Produtos atualizados!';
      _showDialog(context, title, '');
      setState(() {
        _isLoading = false;
      });
    });
  }

  callDogFoodCalculator(context) {
    print('OOIII');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return BulkDogFoodCalculator();
      }),
    );
  }
}

void _showDialog(BuildContext context, String title, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(text),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
