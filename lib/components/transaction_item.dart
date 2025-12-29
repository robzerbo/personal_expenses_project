import 'package:flutter/material.dart';
import 'package:personal_expenses_project/models/transaction.dart';
import 'package:intl/intl.dart' ; 

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemoved,
  });

  final Transaction tr;
  final void Function(String) onRemoved;

  @override
  Widget build(BuildContext context) {
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
        trailing: 
        MediaQuery.of(context).size.width > 375 ?
        TextButton.icon(
          onPressed: ()=> onRemoved(tr.id), 
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          label: Text(
            "Excluir",
            style: TextStyle(
              color: Theme.of(context).colorScheme.error
            ),
          ),
        )
        :
        IconButton(
          onPressed: ()=> onRemoved(tr.id), 
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}