import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final Transaction transaction;

  ListItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          child: FittedBox(
            child: Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.datetime),
        ),
      ),
    );
  }
}
