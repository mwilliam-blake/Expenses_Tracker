import 'package:bloc/bloc.dart';
import 'package:expense_app/data/local/models/expense_filter_model.dart';
import 'package:expense_app/data/local/models/expenses_model.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/local/db/db_helper.dart';
import '../../../domain/app_constants.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DBHelper db;
  DateFormat df = DateFormat.yMMMd();
  int catid=0;

  ExpenseBloc({required this.db}) : super(ExpenseInitialState()) {

    on<AddExpenseEvent>((event, emit) async{
      ///1
      emit(ExpenseLoadingState());
      bool check = await db.addExpense(expense: event.newExpense);

      if(check){
        List<ExpensesModel> allExpenses = await db.fetchExpense();
        ///2
        //emit(ExpenseLoadedState(mExpenses: allExpenses));
        emit(ExpenseFilterLoadedState(mFilteredExpenses: filterExp(allExpenses)));
      } else {
        ///3
        emit(ExpenseErrorState(errorMsg: "Expense not added"));
      }

    });

    on<FetchInitialExpense>((event, emit) async{
      emit(ExpenseLoadingState());

      List<ExpensesModel> allExpenses = await db.fetchExpense();

      emit(ExpenseLoadedState(mExpenses: allExpenses));

    });


    on<FetchFilteredExpense>((event, emit) async{
      emit(ExpenseLoadingState());

      List<ExpensesModel> allExpenses = await db.fetchExpense();
      catid = event.type;
      print(event.type);
      if(event.type==0){
        df = DateFormat.yMMMd();
      } else if(event.type==1){
        df = DateFormat.yMMM();
      } else if(event.type==2){
        df = DateFormat.y();
      }

      emit(ExpenseFilterLoadedState(mFilteredExpenses: filterExp(allExpenses)));

    });

  }

  List<ExpenseFilterModel> filterExp(List<ExpensesModel> allExpenses){
    ///filtering data
    List<ExpenseFilterModel> filteredExpenses = [];

    List<String> uniqueDates = [];
    String eachDate = '';
    String filterd_cid = '';

    for(ExpensesModel eachExp in allExpenses){
      if(catid==3) {
            eachDate = eachExp.cid.toString();
      }
      else {
            eachDate = df.format(
            DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.created_at)));
      }
        if (!uniqueDates.contains(eachDate)) {
          uniqueDates.add(eachDate);
        }
      }

    print(uniqueDates);

    for(String eachDate in uniqueDates){
      num eachMillis = 0;
      num balance = 0.0;
      List<ExpensesModel> eachDateExp = [];
      String eachExpDate = '';
      String ctitle = '';

      for(ExpensesModel eachExp in allExpenses){
        eachMillis = int.parse(eachExp.created_at);
        if(catid==3) {
            eachExpDate = eachExp.cid.toString();
        } else {
            eachExpDate = df.format(DateTime.fromMillisecondsSinceEpoch(
              int.parse(eachExp.created_at)));
        }

        if(eachExpDate==eachDate){
          eachDateExp.add(eachExp);

          if(eachExp.exp_type=="Debit"){
            balance -= eachExp.amt!;
          } else {
            balance += eachExp.amt!;
          }
          ctitle = AppConstant.mCat.where((
              eachCat) {
            return eachCat.cid ==
                eachExp.cid;
          }).toList()[0].cat_title;
        }

      }

      filteredExpenses.add(ExpenseFilterModel(millis: eachMillis, type: eachDate, balance: balance, allExpenses: eachDateExp, cat_title:ctitle, filter_id:catid));


    }

    return filteredExpenses;
  }
}