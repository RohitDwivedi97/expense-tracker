import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final Transaction transaction;

  ListItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                child: FittedBox(
                  child: Text(
                    '\$${transaction.amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(DateFormat.yMMMMd().format(transaction.datetime),
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ))
                  ])
            ]));
  }
}
