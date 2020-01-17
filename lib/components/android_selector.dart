import 'package:flutter/material.dart';

import '../coin_data.dart';

class AndroidCurrencySelector extends StatelessWidget {
  final Function onSelect;
  final String value;

  const AndroidCurrencySelector({this.onSelect, this.value});

  List<DropdownMenuItem<String>> getDropdownItems() {
    return currenciesList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        child: Text(value),
        value: value,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: this.value,
      onChanged: onSelect,
      items: getDropdownItems(),
    );
  }
}
