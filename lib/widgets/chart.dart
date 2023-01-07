import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var tx in recentTransactions) {
        if (tx.datetime.day == weekDay.day &&
            tx.datetime.month == weekDay.month &&
            tx.datetime.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return recentTransactions.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(6),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ...groupedTransactionValues.map((tx) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      tx['day'].toString(),
                      (tx['amount'] as double),
                      totalSpending == 0.0
                          ? 0
                          : (tx['amount'] as double) / totalSpending),
                );
              }).toList()
            ],
          ),
        ));
  }
}
