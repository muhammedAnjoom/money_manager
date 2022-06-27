import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_app/db/category/category_db.dart';
import 'package:money_app/db/transtion/transtion_db.dart';
import 'package:money_app/model/category/category_model.dart';

import '../../model/transtion/transaction_model.dart';

class ScreenTranstions extends StatelessWidget {
  const ScreenTranstions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refresUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifier,
      builder:
          (BuildContext context, List<TransctionModel> newList, Widget? _) {
        return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final _value = newList[index];
              return Slidable(
                key: Key(_value.id!),
                startActionPane: ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        TransactionDb.instance
                            .deleteTransaction(_value.id.toString());
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                      backgroundColor: Colors.red,
                    )
                  ],
                ),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(
                        parseDate(_value.date),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: _value.type == CategoryType.income
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text('RS ${_value.amount}'),
                    subtitle: Text('${_value.category.name}'),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length);
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _spliteDate = _date.split(' ');
    return '${_spliteDate.last}\n${_spliteDate.first}';
    // return '${date.day}\n${date.month}';
  }
}
