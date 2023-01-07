import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransaction;
  NewTransaction({required this.onAddTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var _selectedDate;

  void submitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.onAddTransaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        datetime: _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
          setState(() {
            if(pickedDate == null){
              return;
            }
            _selectedDate = pickedDate;
          });
        });
  }

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
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(_selectedDate == null ? 'No date chosen' : DateFormat.yMd().format(_selectedDate),
                      style: Theme.of(context).textTheme.headline1),
                ),
                TextButton(
                  child: Text('Choose Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  onPressed: _presentDatePicker,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              submitData();
            },
            child: Text('Add Transaction'),
          )
        ],
      ),
    ));
  }
}
