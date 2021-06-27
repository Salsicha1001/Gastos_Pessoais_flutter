import 'package:flutter/material.dart';
import 'package:gastos_flutter/main.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
              left: 10,
              right: 10,
              top: 10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: "Título"),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: valueController,
                decoration: InputDecoration(labelText: "Valor em R\$"),
                onSubmitted: (_) => _submitForm(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada : ${DateFormat('dd/MM/yyyy').format(_selectDate as DateTime)}',
                      ),
                    ),
                    FlatButton(
                      onPressed: _showDatePicker,
                      child: Text('Selecionar Data',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      textColor: Colors.purple,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text(
                      'Nova Transação',
                    ),
                    textColor: Colors.white,
                    color: Colors.purple,
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
