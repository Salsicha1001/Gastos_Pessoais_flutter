import 'package:flutter/material.dart';
import 'package:gastos_flutter/Components/chart.dart';
import 'package:gastos_flutter/Components/transaction_form.dart';
import 'dart:math';
import 'package:gastos_flutter/models/Transaction.dart';

import 'Components/transaction_list.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple, accentColor: Colors.purpleAccent),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transtacions = [
    Transaction(
      id: '1',
      title: 'Tênis',
      value: 200.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: '2',
      title: 'Conta',
      value: 250.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    )
  ];
  List<Transaction> get _recentTransaction {
    return _transtacions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transtacions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _delete(String id) {
    setState(() {
      _transtacions.removeWhere((element) => element.id == id);
    });
  }

  _openForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (c) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),
      ),
      actions: <Widget>[
        IconButton(onPressed: () => _openForm(context), icon: Icon(Icons.add)),
      ],
    );
    final alturaDisponivel = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: alturaDisponivel * 0.25,
                child: Chart(_recentTransaction)),
            Column(
              children: <Widget>[
                Container(
                    height: alturaDisponivel * 0.75,
                    child: TransactionList(_transtacions, _delete)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
