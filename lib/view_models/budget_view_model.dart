/* the budget service below acts as a bridge between the local storage service
and the UI meaning it takes the transaction item model from local storage service
and updates the notifies the widgets to update the UI when needed */

import 'package:budget_tracker_app/models/transaction_item.dart';
import 'package:budget_tracker_app/services/local_storage_service.dart';
import 'package:flutter/foundation.dart';

class BudgetViewModel extends ChangeNotifier {
  //getters
  double getBudget() => LocalStorageService().getBudget();
  double getBalance() => LocalStorageService().getBalance();
  List<TransactionItem> get items => LocalStorageService().getAllTransactions();

  //setters
  set budget(double val) {
    LocalStorageService().saveBudget(val);
    notifyListeners();
  }

  //adding transaction item
  void addItem(TransactionItem item) {
    LocalStorageService().saveTransactionItem(item);
    notifyListeners();
  }

  //deleting transaction items
  void deleteItem(TransactionItem item) {
    final localStorage = LocalStorageService();
    //calling our localstorage service now to delete the item
    localStorage.deleteTransactionItem(item);
    //notifying the listeners
    notifyListeners();
  }
}


























//Architecture below is before using hive and not using updated architecture

// import 'package:budget_tracker_app/models/transaction_item.dart';
// import 'package:flutter/material.dart';

// class BudgetViewModel extends ChangeNotifier {
//   double _budget = 2000.0;

//   double balance = 0.0;

//   //getter for budget value
//   double get budget => _budget;

//   //setter for budget value
//   set budget(double val) {
//     _budget = val;
//     notifyListeners();
//   }

//   //list to add to..
//   final List<TransactionItem> _items = [];

//   //getter for the list above
//   List<TransactionItem> get items => _items;

//   //adding item functionality
//   void addItem(TransactionItem item) {
//     _items.add(item);
//     updateBalance(item);
//     notifyListeners();
//   }

//   //updating balance funtionality
//   void updateBalance(TransactionItem item) {
//     if (item.isExpense) {
//       balance += item.amount;
//     } else {
//       balance -= item.amount;
//     }
//   }
// }
