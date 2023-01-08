import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/transaction.dart';

Future<Database> openDatabaseConnection() async {
  WidgetsFlutterBinding.ensureInitialized();
  return openDatabase(
    join(await getDatabasesPath(), 'expenses_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE expenses(id TEXT PRIMARY KEY, amount REAL, datetime TEXT, title TEXT)',
      );
    },
    version: 1,
  );
}

// Define a function that inserts transaction into the database
Future<void> insertExpense(Expense tx, Database db) async {
  await db.insert(
    'expenses',
    tx.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// A method that retrieves all the dogs from the dogs table.
Future<List<Expense>> getExpenses(Database db) async {
  final List<Map<String, dynamic>> maps = await db.query('expenses');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Expense(
      id: maps[i]['id'],
      amount: double.parse(maps[i]['amount']),
      datetime: maps[i]['datetime'],
      title: maps[i]['title']
    );
  });
}
