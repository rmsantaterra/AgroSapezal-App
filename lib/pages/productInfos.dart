import 'dart:convert';

import 'package:flutter/material.dart';

class ProductInfos extends StatelessWidget {
  final dynamic productData;
  ProductInfos(this.productData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Produto')),
      body: SizedBox.expand(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                productData['imageBase64'] != null
                    ? Image.memory(
                        base64.decode(productData['imageBase64']),
                        fit: BoxFit.fill,
                        width: 280,
                        height: 280,
                      )
                    : Image.asset(
                        'assets/img-default.jpg',
                        fit: BoxFit.fill,
                        width: 280,
                        height: 280,
                      )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Cód Barras: ",
                            style: TextStyle(
                                // color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          Text(
                            // convertJsonProd(productData, 'barcode'),
                            productData['barcode'],
                            style: TextStyle(
                                // color: Colors.blue,
                                fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Código: ",
                            style: TextStyle(
                                // color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          Text(
                            // convertJsonProd(productData, 'barcode'),
                            productData['seqNum'].toString(),
                            style: TextStyle(
                                // color: Colors.blue,
                                fontSize: 14.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nome: ",
                        style: TextStyle(
                            // color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                    Flexible(
                        child: Padding(
                            child: Text(productData['name']),
                            padding: EdgeInsets.only(top: 2))),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 50)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "R\$",
                      style: TextStyle(
                          // color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    ),
                    Text(
                      productData['price'].toDouble().toString(),
                      style: TextStyle(
                          // color: Colors.blue,
                          fontSize: 30.0),
                    )
                  ],
                )
              ],
            ),
          )
          /* Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Nome: ",
                style: TextStyle(
                    // color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              Text(
                "Bifinho tal ",
                style: TextStyle(
                    // color: Colors.blue,
                    fontSize: 14.0),
              )
            ],
          ) */
        ],
      )),
    );
  }
}
