import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            fontFamily: 'OpenSans'
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [
    // Transaction(
    //     id: '1', amount: 350.0, datetime: DateTime.now(), title: 'New Shoes'),
    // Transaction(
    //     id: '1', amount: 370.0, datetime: DateTime.now(), title: 'MacBook Pro')
  ];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.datetime.isAfter(DateTime.now().subtract(const Duration(days: 7),),);
    },).toList();
  }

  void _onAddTrancation(
      {required id, required amount, required datetime, required title}) {
    setState(() {
      var transaction =
          Transaction(id: id, datetime: datetime, title: title, amount: amount);
      transactions.add(transaction);
    });
  }

  void startAddModalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(onAddTransaction: _onAddTrancation);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              startAddModalSheet(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(recentTransactions: _recentTransactions),
              TransactionList(userTransactions: transactions),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddModalSheet(context);
        },
      ),
    );
  }
}
