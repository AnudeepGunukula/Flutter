// ignore_for_file: prefer_const_constructors

import 'package:expenseplanner/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTransaction: deleteTransaction,
                    ))
                .toList());
    // : ListView.builder(
    //     // listview is column with singlechildscrollview and infinite height suitable for less list items
    //     //listview.builder is useful and good in performance if more items present in list bcz of its lazy loading.
    //     itemBuilder: (ctx, index) {
    //       return TransactionItem(
    //         key: ValueKey(transactions[index].id),
    //         transaction: transactions[index],
    //         deleteTransaction: deleteTransaction,
    //       );
    //     },
    //     itemCount: transactions.length,
    //     // children: transactions.map((tx) {}).toList(),
    //   );
  }
}
