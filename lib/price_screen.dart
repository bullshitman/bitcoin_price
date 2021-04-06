import 'package:bitcoin_price/model/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<String> cryproList = ['BTC', 'LTC', 'ETH'];
  String selectedCurrency = 'USD';
  String btcRate = '? USD';
  String ltcRate = '? USD';
  String ethRate = '? USD';
  Currency currency = Currency();

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
        getRate(cryptoList, selectedCurrency);
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
        getRate(cryptoList, selectedCurrency);
      },
    );
  }

  void getRate(List cryptoList, String curr) async {
    for (String cryptoCurr in cryproList) {
      currency = await Currency().getCurrencyRate(cryptoCurr, curr);
      updateUI(currency);
    }
  }

  void updateUI(Currency currency) {
    setState(() {
      if (currency != null) {
        switch (currency.assetIdBase) {
          case ('BTC'):
            btcRate = '${currency.rate.toStringAsFixed(3)} $selectedCurrency';
            break;
          case ('ETH'):
            ethRate = '${currency.rate.toStringAsFixed(3)} $selectedCurrency';
            break;
          case ('LTC'):
            ltcRate = '${currency.rate.toStringAsFixed(3)} $selectedCurrency';
            break;
        }
      } else {
        btcRate = '? $selectedCurrency';
        ltcRate = '? $selectedCurrency';
        ethRate = '? $selectedCurrency';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getRate(cryproList, 'USD');
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
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.lightBlue,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btcRate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.lightBlue,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ltcRate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.lightBlue,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ethRate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
}
