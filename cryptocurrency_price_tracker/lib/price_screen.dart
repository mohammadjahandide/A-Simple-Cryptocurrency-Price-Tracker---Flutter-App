import 'dart:io';

import 'package:cryptocurrency_price_tracker/constants.dart';
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
  String? _selectedCurrency = "USD";


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
          _selectedCurrency = value;
        });
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
          });
        },
        children: items);
  }

  Widget _listViewItem(BuildContext context, int index) {
    return Card(
      color: Colors.orangeAccent,
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${cryptoList[index]}',
              style: kListViewItemTextStyle,
            ),
            Text(
              ' = ? $_selectedCurrency',
              style: kListViewItemTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPicker(){
    if( kIsWeb){
      return _getDropdownButton();
    }
    else{
      if(Platform.isIOS){
        return _getIOSPicker();
      }
      return _getDropdownButton();
    }
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
            Container(
              height: 350,
              child: ListView.builder(
                itemBuilder: (context, index) => _listViewItem(context, index),
                itemCount: cryptoList.length,
              ),
            )
          ],
        ));
  }
}
