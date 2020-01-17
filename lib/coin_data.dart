import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config/constants.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getCoinData({String fromCurrency, String toCurrency}) async {
    if (fromCurrency.isEmpty || toCurrency.isEmpty) {
      print('At least one of two symbols is empty');
      return 0.0;
    }

    try {
      http.Response response =
          await http.get('$kUrlBase$fromCurrency$toCurrency');
      return jsonDecode(response.body)['last'];
    } catch (e) {
      print(e);
      return 0.0;
    }
  }
}
