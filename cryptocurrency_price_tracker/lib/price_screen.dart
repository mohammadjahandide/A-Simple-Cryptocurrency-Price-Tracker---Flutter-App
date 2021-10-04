import 'dart:io';

import 'package:cryptocurrency_price_tracker/constants.dart';
import 'package:cryptocurrency_price_tracker/listview_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = "USD";
  List<String> _amounts = [];

  void _getData() async {
    for (int i = 0; i < cryptoList.length; ++i) {
      var data = await CoinData().getData(cryptoList[i], _selectedCurrency);
      setState(() {
        _amounts[i] = data['rate'].toInt().toString();
      });
    }
  }

  void _initAmountValue() {
    for (int i = 0; i < cryptoList.length; ++i) {
      _amounts[i] = '?';
    }
  }

  @override
  void initState() {
    for (int i = 0; i < cryptoList.length; ++i) {
      _amounts.add('?');
    }
    _getData();
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: kDropdownTextStyle,
        ),
        value: currency,
      );
      items.add(newItem);
    }

    return items;
  }

  DropdownButton<String> _getDropdownButton() {
    return DropdownButton(
      value: _selectedCurrency,
      items: _getDropdownItems(),
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value!;
          _initAmountValue();
        });
        _getData();
      },
    );
  }

  CupertinoPicker _getIOSPicker() {
    List<Text> items = [];

    for (String currency in currenciesList) {
      items.add(Text(
        currency,
        style: kDropdownTextStyle,
      ));
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            _selectedCurrency = currenciesList[selectedIndex];
            _initAmountValue();
          });
          _getData();
        },
        children: items);
  }

  Widget _getPicker() {
    if (kIsWeb) {
      return _getDropdownButton();
    } else {
      if (Platform.isIOS) {
        return _getIOSPicker();
      }
      return _getDropdownButton();
    }
  }

  Widget _listViewItem(BuildContext context, int index) {
    return ListViewItems(
        crypto: cryptoList[index],
        currency: _selectedCurrency,
        amount: _amounts[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Coin Ticker',
            style: kAppBarTextStyle,
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: _getPicker(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => _listViewItem(context, index),
                itemCount: cryptoList.length,
              ),
            )
          ],
        ));
  }
}
