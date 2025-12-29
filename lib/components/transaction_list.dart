import 'package:flutter/material.dart';
import 'package:personal_expenses_project/components/transaction_item.dart';
import 'package:personal_expenses_project/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemoved;
  
  const TransactionList({super.key, required this.transactions, required this.onRemoved});

  @override
  Widget build(BuildContext context) {
    return 
      transactions.isNotEmpty ? ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index){
          final tr = transactions[index];
          return TransactionItem(tr: tr, onRemoved: onRemoved);
        },
        // return Card(
          //   elevation: 2,
          //   child: Row(children: [
          //     Container(
          //       margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //           color: Theme.of(context).colorScheme.primary,
          //           width: 2,
                    
          //         ),
          //         borderRadius: BorderRadius.circular(20)
          //       ),
          //       padding: EdgeInsets.all(10),
      
          //       child: Text(
          //         "R\$ ${tr.value.toStringAsFixed(2)}", 
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
          //           fontSize: 20,
          //           color: Theme.of(context).colorScheme.primary
          //         ) 
          //       )
          //     ),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //         Text(
          //           tr.title, 
          //           softWrap: true,
          //           style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold
          //           ),
          //         ),
          //         Text(
          //           DateFormat('d MMM yyyy').format(tr.date),
          //           style: TextStyle(
          //             color: Theme.of(context).colorScheme.outline
          //           ),
          //           )
          //       ],),
          //     )
          //   ],)
          // );
      ) 
      :
      LayoutBuilder(
        builder: (ctx, constraints){
          return Column(
          children: [
            SizedBox(height: 20,),
            Text(
              "Nenhum gasto registrado...",
              style: TextStyle(
                fontFamily: Theme.of(context).appBarTheme.titleTextStyle?.fontFamily,
                fontSize: 20
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                "assets/fonts/images/empty-wallet.webp", 
                fit: BoxFit.cover,  
              ),
            )
          ],
        );
        },
      );
    }
}