import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteById;

  ListItem({required this.transaction, required this.deleteById});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
                ),
              ),
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
        trailing: IconButton(
          color: Theme.of(context).errorColor,
          icon: Icon(Icons.delete),
          onPressed: () => deleteById(transaction.id),
        ),
      ),
    );
  }
}
