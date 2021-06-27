import 'package:flutter/material.dart';
import 'package:gastos_flutter/models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDelete;

  TransactionList(this.transactions, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'Nenhuma Transação cadastrada!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
              Container(
                  height: 200,
                  child: Image.network(
                    'https://img.icons8.com/ios/452/sleep.png',
                    fit: BoxFit.cover,
                  ))
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Container(
                      height: 20,
                      child: FittedBox(
                          child: Text('R\$ ${tr.value.toStringAsFixed(2)}')),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed:()=>onDelete(tr.id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
          );
  }
}
