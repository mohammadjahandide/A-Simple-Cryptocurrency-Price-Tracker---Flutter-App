import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
  'XLM',
  'BNB',
  'ADA',
  'DOGE',
  'XRP',
  'BCH',
  'LINK',
];

//TODO : add your apikey
const apiKey = '';
const url = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getData(String coin, String currency) async {
    http.Response response =
        await http.get(Uri.parse('$url/$coin/$currency?apikey=$apiKey'));
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw 'something wrong ${response.statusCode}';
    }
  }
}
