import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/android_selector.dart';
import 'components/ios_selector.dart';
import 'coin_data.dart';

const selectorType = 'IOS';

class PriceScreen extends StatefulWidget {
  final btcValue;
  final ethValue;
  final ltcValue;

  const PriceScreen({this.btcValue, this.ethValue, this.ltcValue});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'USD';
  String btcValue = '?';
  String ethValue = '?';
  String ltcValue = '?';

  updateQuotations(String toCurrency) async {
    double result;

    setState(() {
      selectedCurrency = toCurrency;
    });

    var results = new Map();

    for (String item in cryptoList) {
      result = await coinData.getCoinData(
        fromCurrency: item,
        toCurrency: toCurrency,
      );

      results[item] = result.toStringAsFixed(2);
    }

    setState(() {
      btcValue = results['BTC'];
      ethValue = results['ETH'];
      ltcValue = results['LTC'];
    });
  }

  List<Widget> getQuotationCards() {
    List<Widget> quotationCards = [];

    for (int i = 0; i < cryptoList.length; i++) {
      String text;

      if (cryptoList[i] == 'BTC') {
        text = '$i ${cryptoList[i]} = $btcValue $selectedCurrency';
      } else if (cryptoList[i] == 'ETH') {
        text = '$i ${cryptoList[i]} = $ethValue $selectedCurrency';
      } else if (cryptoList[i] == 'LTC') {
        text = '$i ${cryptoList[i]} = $ltcValue $selectedCurrency';
      }

      Widget card = Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      );
      quotationCards.add(card);
    }

    return quotationCards;
  }

  @override
  void initState() {
    super.initState();
    btcValue = widget.btcValue;
    ethValue = widget.ethValue;
    ltcValue = widget.ltcValue;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getQuotationCards(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: selectorType == 'IOS'
                ? IOSCurrencySelector(
                    onSelect: (index) {
                      updateQuotations(currenciesList[index]);
                    },
                  )
                : AndroidCurrencySelector(
                    value: selectedCurrency,
                    onSelect: (value) {
                      updateQuotations(value);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
