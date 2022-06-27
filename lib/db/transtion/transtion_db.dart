import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_app/model/transtion/transaction_model.dart';

const TRANSACTION_DB_NAME ='transaction-db';

abstract class TransactionDbFunction{
  Future<void> addTransaction(TransctionModel obj);
  Future<List<TransctionModel>> getTransaction();
  Future<void> deleteTransaction(String transactionId);
}

class TransactionDb extends TransactionDbFunction {
  TransactionDb._interal();

  static TransactionDb instance = TransactionDb._interal();

  factory TransactionDb(){
    return instance;
  }


  ValueNotifier<List<TransctionModel>> transactionListNotifier = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransctionModel obj) async{
   final _db = await  Hive.openBox<TransctionModel>(TRANSACTION_DB_NAME);
   _db.put(obj.id, obj);
  //  refer();
  }

  Future<void> refresh() async{
    final _list = await getTransaction();
    _list.sort((first,second)=> second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }
  
  @override
  Future<List<TransctionModel>> getTransaction() async{
    final _db = await Hive.openBox<TransctionModel>(TRANSACTION_DB_NAME);
    
    return _db.values.toList();

  }
  
  @override
  Future<void> deleteTransaction(String transactionId) async{
    final _db = await Hive.openBox<TransctionModel>(TRANSACTION_DB_NAME);
    await _db.delete(transactionId);
    refresh();

  }
  
 
}