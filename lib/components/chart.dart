import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_project/components/chart_bar.dart';
import 'package:personal_expenses_project/models/transaction.dart';

class Chart extends StatelessWidget {
  
  final List<Transaction> recentTransactions;
  
  const Chart({super.key, required this.recentTransactions});

  double get _weekTotalValue{
    return groupedTransactions.fold(0, (sum, tr){
      return sum + (tr['value'] as double);
    });
  }  
  
  List<Map<String, Object>> get groupedTransactions{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double valueSum = 0.0;

      for(Transaction transaction in recentTransactions){
        bool isSameDay = transaction.date.day == weekDay.day;
        bool isSameMonth = transaction.date.month == weekDay.month;
        bool isSameYear = transaction.date.year == weekDay.year;

        if(isSameDay && isSameMonth && isSameYear){
          valueSum += transaction.value;
        }

      }

      return {'day' : DateFormat.E().format(weekDay)[0], 'value' : valueSum}; 
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: 
            groupedTransactions.map((tr){
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tr['day'].toString(), 
                  value: double.parse(tr['value'].toString()), 
                  percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue
                )
              );
            }).toList(),
        ),
      ),
    );
  }
}