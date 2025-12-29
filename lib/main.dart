import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_project/components/chart.dart';
import 'dart:math';
import 'dart:io';
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

  bool _showChart = false;

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

  Widget _getIconButton(IconData icon, Function() fn){
    return Platform.isAndroid ?
    GestureDetector(
      onTap: fn, 
      child: Icon(icon)
    )
    :
    IconButton(
      onPressed: fn, 
      icon: Icon(icon)
    );
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isAndroid ? Icons.list : CupertinoIcons.refresh;
    final chartList = Platform.isAndroid ? Icons.bar_chart_rounded : CupertinoIcons.refresh;

    final appBarActions = [
        if(isLandScape)
        _getIconButton(
          _showChart ? iconList : chartList,
          (){setState(() {_showChart = !_showChart;});}
        ),
        _getIconButton(
          Platform.isAndroid ? Icons.add : CupertinoIcons.add,
          () => _openTransactionFormModal(context)
        )
      ];
    
    final PreferredSizeWidget appBar = Platform.isAndroid ?
    AppBar(
      title: Text("Despesas Pessoais"),
      centerTitle: true,
      actions: appBarActions,
    )
    :
    CupertinoNavigationBar(
      middle: Text('Despesas Pessoais'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: appBarActions,
      ),
    );

    final availabelHeight = mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView( // precisa definir o tamanho da tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(_showChart || !isLandScape) 
              SizedBox(
                height: availabelHeight * (isLandScape ? 0.7 : 0.25),
                child: Chart(recentTransactions: _recentTransactions)) ,
            if(!_showChart || !isLandScape) 
              SizedBox(
                height: availabelHeight * (isLandScape ? 1 : 0.70),
                child: TransactionList(transactions: _transactions, onRemoved: _removeTransaction)),
          ],
        ),
      ),
    );

    return Platform.isAndroid ?
    Scaffold(
      appBar: appBar,
      body: bodyPage,
      floatingActionButton: Platform.isIOS ?
      Container()
      :
      FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        onPressed: () => _openTransactionFormModal(context), 
        child: Icon(Icons.add),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    )
    :
    CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text('Despesas Pessoais'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: appBarActions,
      ),
    ),
    child: bodyPage,
  );
  }
}