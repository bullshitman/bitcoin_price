import 'package:bitcoin_price/network/network_helper.dart';
import 'package:bitcoin_price/consts.dart';

class Currency {
  String time;
  String assetIdBase;
  String assetIdQuote;
  double rate;

  Currency({this.time, this.assetIdBase, this.assetIdQuote, this.rate});

  Currency.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    assetIdBase = json['asset_id_base'];
    assetIdQuote = json['asset_id_quote'];
    rate = json['rate'];
  }
  Future<Currency> getCurrencyRate(String cryptoCurr, String curr) async {
    NetWorkHelper netWorkHelper =
        NetWorkHelper('$baseUrl$cryptoCurr/$curr?apikey=$apiK');
    var data = await netWorkHelper.getData();
    return Currency.fromJson(data);
  }
}
