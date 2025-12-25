import 'package:flutter/material.dart';
import 'package:personal_expenses_project/components/chart.dart';
import 'dart:math';
import 'package:personal_expenses_project/components/transaction_form.dart';
import 'package:personal_expenses_project/components/transaction_list.dart';
import 'package:personal_expenses_project/models/transaction.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        // useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.amber
          ),
          titleTextStyle: TextStyle(
            fontFamily: 'SairaStencilOne',
            fontSize: 30
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'SairaStencilOne',
            fontSize: 20
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white70,
          primary: Colors.blue,
          secondary: Colors.amber,
          onSurface: Colors.black,
          outline: Colors.blueGrey,
          surface: Colors.white
        ),
        fontFamily: 'NotoSerif'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final List<Transaction> _transactions = [
    Transaction(id: "t1", title: "Comida - Mercado Extrabom", value: 150.255555, date: DateTime.now().subtract(Duration(days: 3))), 
    Transaction(id: "t2", title: "Corte de Cabelo", value: 50.9999, date: DateTime.now().subtract(Duration(days: 4))), 
    Transaction(id: "t3", title: "Presente de Natal para Mãe", value: 299, date: DateTime.now().subtract(Duration(days: 5))), 
    Transaction(id: "t4", title: "Chocolate para afogar as mágoas", value: 15, date: DateTime.now().subtract(Duration(days: 6))), 
    Transaction(id: "t6", title: "Aluguel Dezembro", value: 1030, date: DateTime.now().subtract(Duration(days: 7))), 
    Transaction(id: "t7", title: "Presente da Pepe", value: 11.60, date: DateTime.now().subtract(Duration(days: 3))), 
    Transaction(id: "t8", title: "Presente da Pepe", value: 11.60, date: DateTime.now().subtract(Duration(days: 30))), 
  ];

  List<Transaction> get _recentTransactions{
    return _transactions.where((tr){
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)));
      }).toList();
  }

  void _addTransaction(String title, double value, DateTime date){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(), 
      title: title, 
      value: value, 
      date: date
      );

      setState(() {
        _transactions.add(newTransaction);
      });

      Navigator.of(context).pop(); 
  }

  void _removeTransaction(String id){
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  dynamic _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (_){
        return TransactionForm(onSubmit: _addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context), 
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: SingleChildScrollView( // precisa definir o tamanho da tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions),
            TransactionList(transactions: _transactions, onRemoved: _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        onPressed: () => _openTransactionFormModal(context), 
        child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}