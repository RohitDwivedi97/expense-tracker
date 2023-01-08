import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';
import './database/database_service.dart';
import 'dart:async';
import 'package:flutter/services.dart';

var db;
void main() async {
  db = await openDatabaseConnection();
  // One solution to fix the UI in landscape mode is to is to not allow landscape mode at all.
  // so let's try that out. 
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

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
              fontSize: 14.0,
              fontFamily: 'OpenSans',
            ),
          ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Expense> transactions = [];
  List<Expense> get _recentTransactions {
    return transactions.where(
      (tx) {
        return DateTime.parse(tx.datetime).isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  _MyHomePageState() {
    getExpenses(db).then((value) {
      setState(() {
        transactions.addAll(value);
      });
    });
  }

  void _onAddTrancation(
      {required id, required amount, required datetime, required title}) {
    var expense = Expense(
        id: id, datetime: datetime.toString(), title: title, amount: amount);
    insertExpense(expense, db);
    setState(() {
      transactions.add(expense);
    });
  }

  void startAddModalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(onAddTransaction: _onAddTrancation);
        });
  }

  void _deleteById(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              startAddModalSheet(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) * 0.25,
                  child: Chart(recentTransactions: _recentTransactions),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) * 0.6,
                  child: TransactionList(
                      userTransactions: transactions, deleteById: _deleteById),
                ),
              ]),
        ),
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
