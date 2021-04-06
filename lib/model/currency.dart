import 'dart:convert';

import 'package:bitcoin_price/network/network_helper.dart';
import 'package:bitcoin_price/consts.dart';
import 'package:bitcoin_price/coin_data.dart';

class Currency {
  Future<Map<String, String>> getCurrencyRate(String curr) async {
    Map<String, String> cryptoRate = {};
    for (String crypto in cryptoList) {
      NetWorkHelper netWorkHelper =
          NetWorkHelper('$baseUrl$crypto/$curr?apikey=$apiK');
      var response = await netWorkHelper.getData();
      if (response.statusCode == 200) {
        print('Response ${response.body}');
        cryptoRate[crypto] = jsonDecode(response.body)['rate'];
      } else {
        cryptoRate[crypto] = '?';
        print(response.statusCode);
      }
    }
    return cryptoRate;
  }
}
