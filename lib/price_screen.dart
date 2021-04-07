import 'package:bitcoin_price/model/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'widgets/crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  Map<String, String> cryptoRates = {};

  //IOS
  CupertinoPicker IOSPicker() {
    List<Text> pickerList = [];
    for (String curr in currenciesList) {
      pickerList.add(
        Text(curr),
      );
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        getRate();
      },
      children: pickerList,
    );
  }

  //Android
  DropdownButton<String> androidDropDownMenu() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String curr in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(curr),
          value: curr,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getRate();
      },
    );
  }

  void getRate() async {
    var response = await Currency().getCurrencyRate(selectedCurrency);
    setState(() {
      cryptoRates = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          cardCreator(),
          Container(
            color: Colors.lightBlue,
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            child: Platform.isIOS ? IOSPicker() : androidDropDownMenu(),
          ),
        ],
      ),
    );
  }

  Column cardCreator() {
    List<Widget> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(CryptoCurrencyCard(
          cryptoName: crypto,
          rate: cryptoRates[crypto],
          currName: selectedCurrency));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }
}
