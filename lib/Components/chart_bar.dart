import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double value;
  final double percent;

  Chartbar({required this.label, required this.percent, required this.value});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: Text(
                'R\$${value.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  FractionallySizedBox(
                    heightFactor: percent,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.purple),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(label)))
          ],
        );
      },
    );
  }
}
