import 'package:flutter/material.dart';
import 'package:intl/intl.dart' ; 

class TransactionForm extends StatefulWidget {
  
  final void Function(String, double, DateTime) onSubmit;
  
  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm(){
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0){
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  void _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return ;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    onSubmitted: (_) => _submitForm(),
                    decoration: InputDecoration(
                      labelText: "Descrição"
                    ),
                  ),
                  TextField(
                    controller: _valueController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitForm(),
                    decoration: InputDecoration(
                      labelText: "Valor (R\$)"
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}', 
                          style: TextStyle(
                            fontFamily: 'NotoSerif'
                          ),),
                        ),
                        TextButton(onPressed: _showDatePicker, 
                        child: Text('Alterar Data', 
                        style: TextStyle(
                          fontFamily: 'SairaStencilOne'
                        ),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton(
                          onPressed: _submitForm, 
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary
                          ),
                          child: Text("Adicionar Gasto")
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}