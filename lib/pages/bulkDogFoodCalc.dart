import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class BulkDogFoodCalculator extends StatefulWidget {
  @override
  _BulkDogFoodCalculatorState createState() => _BulkDogFoodCalculatorState();
}

class _BulkDogFoodCalculatorState extends State<BulkDogFoodCalculator> {
  var bagValueController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final feedWeightController = TextEditingController();
  final profitController = TextEditingController(text: '15');
  var bulkValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calcular Valor a Granel')),
      body: SizedBox.expand(
          child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                autofocus: true,
                                controller: bagValueController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calcBulkValue();
                                },
                                decoration: InputDecoration(
                                    labelText: 'Valor Saco',
                                    prefix: Text('R\$'),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: feedWeightController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calcBulkValue();
                                },
                                // maxLength: 2,
                                decoration: InputDecoration(
                                    labelText: 'Peso',
                                    suffix: Text('KG'),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: profitController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calcBulkValue();
                                },
                                decoration: InputDecoration(
                                    labelText: 'Lucro',
                                    suffix: Text('%'),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))))),
                          ),
                        ),
                        canShowClearIcon(context),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          bulkValue,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        canShowLowProfit()
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Widget canShowClearIcon(BuildContext context) {
    var bagValue =
        double.parse(bagValueController.value.text.replaceAll(',', '.'));
    var feedWeight = feedWeightController.value.text != ''
        ? int.parse(feedWeightController.value.text)
        : 0;

    if (bagValue != 0 || feedWeight != 0) {
      return GestureDetector(
        onTap: () {
          clearAllFields(context);
        },
        child: Icon(Icons.clear, color: Colors.red.shade500, size: 24),
      );
    } else {
      return Row();
    }
  }

  Widget canShowLowProfit() {
    var profit = profitController.value.text != ''
        ? int.parse(profitController.value.text)
        : 0;

    if (profit < 15) {
      return Text(
        '% Lucro não pode ser menor que 15%',
        style: TextStyle(color: Colors.red.shade400),
      );
    } else {
      return Row();
    }
  }

  clearAllFields(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());

    bagValueController.text = '0,00';
    feedWeightController.clear();
    profitController.text = '15';
    bulkValue = '';

    setState(() {});
  }

  calcBulkValue() {
    var bagValue =
        double.parse(bagValueController.value.text.replaceAll(',', '.'));
    var feedWeight = feedWeightController.value.text != ''
        ? int.parse(feedWeightController.value.text)
        : 0;
    var profit = profitController.value.text != ''
        ? int.parse(profitController.value.text)
        : 0;

    if (bagValue != 0 && feedWeight != 0 && profit >= 15) {
      double bulkValue =
          (bagValue / feedWeight) + (bagValue / feedWeight) * (profit / 100);

      setState(() {
        this.bulkValue = 'R\$' + roundDouble(bulkValue);
      });
    } else {
      setState(() {
        this.bulkValue = '';
      });
    }
  }

  String roundDouble(double value) {
    String valueRounded = value.toStringAsFixed(2);

    while (valueRounded[valueRounded.length - 1] != '0') {
      double valueDouble = double.parse(valueRounded) + 0.01;
      valueRounded = valueDouble.toStringAsFixed(2);
    }

    return valueRounded.replaceAll('.', ',');
  }
}
