import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransaction;
  NewTransaction({required this.onAddTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }
    widget.onAddTransaction(
        id: (++id).toString(),
        title: title,
        amount: amount,
        datetime: DateTime.now());
    Navigator.of(context).pop();
  }

  int id = 4;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController),
          FlatButton(
              onPressed: () {
                submitData();
              },
              child: Text('Add Transaction'))
        ],
      ),
    ));
  }
}
