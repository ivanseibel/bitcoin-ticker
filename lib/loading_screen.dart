import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'coin_data.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String btcValue, ethValue, ltcValue;

  getInitialQuotations() async {
    CoinData coinData = CoinData();
    double result;

    result = await coinData.getCoinData(
      fromCurrency: 'BTC',
      toCurrency: 'USD',
    );
    btcValue = result.toStringAsFixed(2);

    result = await coinData.getCoinData(
      fromCurrency: 'ETH',
      toCurrency: 'USD',
    );
    ethValue = result.toStringAsFixed(2);

    result = await coinData.getCoinData(
      fromCurrency: 'LTC',
      toCurrency: 'USD',
    );
    ltcValue = result.toStringAsFixed(2);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
        btcValue: btcValue,
        ethValue: ethValue,
        ltcValue: ltcValue,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getInitialQuotations();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
