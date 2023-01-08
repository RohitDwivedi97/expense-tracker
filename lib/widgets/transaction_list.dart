import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './listItem.dart';

class TransactionList extends StatelessWidget {
  final List<Expense> userTransactions;
  final Function deleteById;

  TransactionList({required this.userTransactions, required this.deleteById});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: userTransactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet.',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: userTransactions.length,
              itemBuilder: (context, index) {
                return ListItem(
                  transaction: userTransactions[index],
                  deleteById: deleteById,
                );
              },
            ),
    );
  }
}
