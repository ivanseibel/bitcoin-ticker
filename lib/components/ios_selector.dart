import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../coin_data.dart';

class IOSCurrencySelector extends StatelessWidget {
  final Function onSelect;
  const IOSCurrencySelector({this.onSelect});

  List<Widget> getPickerItems() {
    List<Text> currencyItems = [];

    for (var item in currenciesList) {
      currencyItems.add(Text(item));
    }
    return currencyItems;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      looping: true,
      itemExtent: 32.0,
      onSelectedItemChanged: onSelect,
      children: getPickerItems(),
    );
  }
}
