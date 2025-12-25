import 'package:flutter/material.dart';
import 'package:personal_expenses_project/models/transaction.dart';
import 'package:intl/intl.dart' ; 

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemoved;
  
  const TransactionList({super.key, required this.transactions, required this.onRemoved});

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        height: 650,
        child: transactions.isNotEmpty ? ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index){
            final tr = transactions[index];
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(
                      child: Text(
                        "R\$${tr.value.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).appBarTheme.foregroundColor
                        ),
                      )
                    ),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    // fontWeight: 
                  ),
                ),
                subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                trailing: IconButton(
                  onPressed: ()=> onRemoved(tr.id), 
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
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
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Nenhum gasto registrado...",
                style: TextStyle(
                  fontFamily: Theme.of(context).appBarTheme.titleTextStyle?.fontFamily,
                  fontSize: 20
                ),
              ),
            ),
            Container(
              height: 200,
              child: Image.asset(
                "assets/fonts/images/empty-wallet.webp", 
                fit: BoxFit.cover,  
              ),
            )
          ],
        )
      );
    }
}