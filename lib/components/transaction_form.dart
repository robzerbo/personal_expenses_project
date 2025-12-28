import 'package:flutter/material.dart';
import 'package:personal_expenses_project/components/adaptative_date_picker.dart';
import 'package:personal_expenses_project/components/adaptative_text_field.dart'; 
import 'adaptative_button.dart';

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

  

  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextfield(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                label: "Descrição",
              ),
              AdaptativeTextfield(
                controller: _valueController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitForm(),
                label: "Valor (R\$)",
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate){
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptativeButton(
                      label: "Adicionar Gasto",
                      onPressed: _submitForm, 
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}