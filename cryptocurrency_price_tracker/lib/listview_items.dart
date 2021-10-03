import 'package:flutter/material.dart';

import 'constants.dart';

class ListViewItems extends StatelessWidget {
  final String crypto;
  final String currency;
  final String amount;

  ListViewItems(
      {required this.crypto, required this.currency, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orangeAccent,
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //crypto name
            Text(
              '$crypto',
              style: kListViewItemTextStyle,
            ),
            Text(
              ' = $amount $currency',
              style: kListViewItemTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
