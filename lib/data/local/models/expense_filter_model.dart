import 'package:expense_app/data/local/models/expenses_model.dart';

class ExpenseFilterModel {
  ///num millis;
  String type;
  num balance;
  List<ExpensesModel> allExpenses;
  ///String cat_title;
  ///int filter_id;

  //ExpenseFilterModel({required this.millis, required this.type, required this.balance, required this.allExpenses, required this.cat_title, required this.filter_id});
  ExpenseFilterModel({required this.type, required this.balance, required this.allExpenses});
}