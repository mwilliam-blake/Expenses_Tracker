import 'dart:math';

import 'package:expense_app/UI/screens/add_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/models/expense_filter_model.dart';
import '../../domain/app_constants.dart';
import 'bloc/expense_bloc.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<ExpenseFilterModel> filteredExpenses = [];
  /* List<Map<String, dynamic>> expenses = [
    {
      "date": "Tuesday, 14",
      "amount": -1380,
      "sublist": [{
        "title": "Shop",
        "desc": "Buy new clothes",
        "samount": -90,
        "icon": Icons.shopping_cart_outlined,
        },
        {
          "title": "Electronic",
          "desc": "Buy new iphone 14",
          "samount": -1290,
          "icon": Icons.phone_android,
        }],
    },
    {
      "date": "Monday, 13",
      "amount": -60,
      "sublist": [{
        "title": "Transportation",
        "desc": "Trip to Malang",
        "samount": -60,
        "icon": Icons.emoji_transportation,
      }],
    },
  ]; */

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchFilteredExpense(type: 0));
  }

  String selectedFilter = "Date wise";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "lib/domain/app/assets/images/icon.png",
                        height: 40,
                        width: 40,
                      ),
                      Text(
                        "Monety",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],),
                  Icon(Icons.search, size: 28,),
                ],
              ),
              const SizedBox(height: 20),

              // Greeting and Filter Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text("Morning", style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Row(
                        children: [
                          Image.asset(
                            "lib/domain/app/assets/images/avathar.png",
                            height: 40,
                            width: 40,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(" Morning", style: TextStyle(
                                  color: Colors.grey, fontSize: 16)),
                              Text(
                                " Shajakhan",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.greenAccent,
                      value: selectedFilter,
                      onChanged: (String? newValue) {
                        int selectedType=0;
                        if(newValue=="Date wise"){
                          selectedType=0;
                        } else if(newValue=="Month wise"){
                          selectedType=1;
                        } else if(newValue=="Category wise"){
                          selectedType=3;
                        } else {
                          selectedType=2;
                        }
                        context.read<ExpenseBloc>().add(FetchFilteredExpense(type: selectedType));

                        setState(() {
                          selectedFilter = newValue!;
                        });
                      },
                      items: <String>["Date wise", "Month wise", "Year wise", "Category wise"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Expense Total Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF727DD6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expense total",
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        Text("\$3,734",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8,
                                  vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                "+\$240",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text("than last month", style: TextStyle(color: Colors
                                .white)),
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      "lib/domain/app/assets/images/status.png",
                      height: 120,
                      width: 145,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Expense List Title
              Text(
                "Expense List",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Expense List
              Expanded(
                child:
                BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (_, state) {
                  if (state is ExpenseLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ExpenseErrorState) {
                    return Center(
                      child: Text(state.errorMsg),
                    );
                  }

                  if (state is ExpenseFilterLoadedState) {
                    return state.mFilteredExpenses.isNotEmpty
                        ?
                    ListView.builder(
                      itemCount: state.mFilteredExpenses.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(state.mFilteredExpenses[index].filter_id==3?state.mFilteredExpenses[index].cat_title:state.mFilteredExpenses[index].type,
                                      style: TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black87)),
                                  Text("\$ ${state.mFilteredExpenses[index]
                                      .balance}", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: state.mFilteredExpenses[index]
                                        .balance < 0
                                        ? Colors.black87
                                        : Colors.black87,
                                  ),),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(),
                              Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.mFilteredExpenses[index]
                                      .allExpenses.length,
                                  itemBuilder: (_, indx) {
                                    return
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(7),
                                                  width: 50,
                                                  height: 50,
                                                  child: Image.asset(
                                                      AppConstant.mCat.where((
                                                          eachCat) {
                                                        return eachCat.cid ==
                                                            state
                                                                .mFilteredExpenses[index]
                                                                .allExpenses[indx]
                                                                .cid;
                                                      }).toList()[0].cat_img),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(11),
                                                      color: Colors
                                                          .primaries[Random()
                                                          .nextInt(
                                                          Colors.primaries
                                                              .length - 1)]
                                                          .shade100
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(state
                                                        .mFilteredExpenses[index]
                                                        .allExpenses[indx].title,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight
                                                                .w600)),
                                                    Text(state
                                                        .mFilteredExpenses[index]
                                                        .allExpenses[indx].desc,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey)),
                                                  ],
                                                ),
                                              ],),
                                            Text("\$ ${state
                                                .mFilteredExpenses[index]
                                                .allExpenses[indx].amt}",
                                                style: TextStyle(fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: state
                                                      .mFilteredExpenses[index]
                                                      .allExpenses[indx].amt! <
                                                      0
                                                      ? Colors.red.shade300
                                                      : Colors.green
                                                      .shade300,)),
                                          ],
                                        ),
                                      );
                                  },),),
                            ],
                          ),
                        );
                      },
                    ) : Center(
                      child: Text('No Expenses yet!!'),
                    );
                  }
                  return Container();
                }
              ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExpensePage()));
      }, child: Icon(Icons.add),),
    );
  }
}

class StatisticPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Statistics")),
      body: Center(
        child: Text(
          "Statistic Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}