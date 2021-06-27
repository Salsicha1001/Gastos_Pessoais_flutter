import 'package:flutter/material.dart';
import 'package:gastos_flutter/Components/chart_bar.dart';
import 'package:gastos_flutter/models/Transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSoma = 0.0;
      for (var e = 0; e < recentTransactions.length; e++) {
        bool sameDay = recentTransactions[e].date.day == weekDay.day;
        bool sameMonth = recentTransactions[e].date.month == weekDay.month;
        bool sameYear = recentTransactions[e].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSoma += recentTransactions[e].value;
        }
      }
      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSoma};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupTransaction.fold(0, (sum, element) {
      final double e = element['value'] as double;
      return sum + e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10) ,
                child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransaction.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: Chartbar(
                    label: e['day'].toString(),
                    percent: _weekTotalValue ==0 ? 0 : (e['value'] as double) / _weekTotalValue,
                    value: e['value'] as double),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
