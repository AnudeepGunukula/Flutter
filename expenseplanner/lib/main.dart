// ignore_for_file: prefer_const_constructors,

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:expenseplanner/models/transaction.dart';
import 'package:expenseplanner/new_transaction.dart';
import 'package:expenseplanner/transactionlist.dart';
import 'package:expenseplanner/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        accentColor: Colors.yellow,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  List<Transaction> _userTransactions = [
    // Transaction(
    //   id: DateTime.now().toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().add(Duration(hours: 1)).toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().add(Duration(hours: 2)).toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().add(Duration(hours: 3)).toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().add(Duration(hours: 4)).toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().add(Duration(hours: 5)).toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().add(Duration(hours: 6)).toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().add(Duration(hours: 7)).toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: DateTime.now().add(Duration(hours: 8)).toString(),
    //   title: 'test1',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    _userTransactions = _userTransactions.reversed.toList();
    _userTransactions.add(newTx);
    setState(() {
      _userTransactions = _userTransactions.reversed.toList();
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListwidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show Chart'),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (bool value) {
              setState(() {
                _showChart = value;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : txListwidget,
    ];
  }

  List<Widget> _buildPotraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
        title: Text(
          'Personal Expenses',
          // style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ]);

    final txListwidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, txListwidget),
            if (!isLandscape)
              ..._buildPotraitContent(mediaQuery, appBar, txListwidget),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
