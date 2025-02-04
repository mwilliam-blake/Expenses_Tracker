import 'package:expense_app/UI/screens/bloc/expense_bloc.dart';
import 'package:expense_app/UI/screens/onboarding/splash/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/local/db/db_helper.dart';
import '../../data/local/models/expenses_model.dart';
import '../../domain/app_constants.dart';

class AddExpensePage extends StatefulWidget{

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  DBHelper db = DBHelper.getInstance();
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  TextEditingController amtController = TextEditingController();

  List<String> mType = ["Debit", "Credit", "Loan", "Borrow", "Lend"];

  String selectedType = "Debit";
  int selectedCatIndex = -1;
  DateTime? selectedDateTime;

  DateFormat df = DateFormat.MMMEd();

  Widget botm_scfol = Center(child: Text("Choose a Category", style: TextStyle(fontSize: 16),));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      borderSide: BorderSide(
                        color: Color(0xffdfd3d3),
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      borderSide: BorderSide(
                        color: Color(0xffdfd3d3),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  hintText: "Enter Description",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      borderSide: BorderSide(
                        color: Color(0xffdfd3d3),
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      borderSide: BorderSide(
                        color: Color(0xffdfd3d3),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: amtController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Amount",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      borderSide: BorderSide(
                        color: Color(0xffdfd3d3),
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      borderSide: BorderSide(
                        color: Color(0xffdfd3d3),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
          
              /*SizedBox(
                width: 200,
                child: DropdownButton(
                  value: selectedType,
                    items: mType.map((value){
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(), onChanged: (value){
                  selectedType = value!;
                  setState(() {
          
                  });
                }),
              ),*/
              DropdownMenu(
                  width: double.infinity,
                  label: Text('Expense Type'),
                  inputDecorationTheme: InputDecorationTheme(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.indigo,
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.indigo,
                          ),
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  initialSelection: selectedType,
                  onSelected: (value){
                    selectedType = value!;
                  },
                  dropdownMenuEntries: mType.map((value){
                    return DropdownMenuEntry(value: value, label: value);
                  }).toList()),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (context) => Container(
                    padding: EdgeInsets.only(top: 11),
                    child: GridView.builder(
                        itemCount: AppConstant.mCat.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (_, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(onTap: (){
                              selectedCatIndex = index;
                              botm_scfol = selected_expense(img: AppConstant.mCat[index].cat_img, cat: AppConstant.mCat[index].cat_title);
                              setState(() {
          
                              });
                              Navigator.pop(context);
                            }, child: Image.asset(AppConstant.mCat[index].cat_img, width: 50, height: 50,)),
                            //Icon(Icons.account_circle_rounded, color: Colors.green, size: 50,),
                            SizedBox(height: 10,),
                            Text(AppConstant.mCat[index].cat_title)
                          ],
                        ),
                      );
                    }),
                  ),);
                },
                child: Container(
                  width: double.infinity,
                  height: 53,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Colors.indigo,
                    ),
                  ),
                  child: botm_scfol,
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () async {
                  selectedDateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2023),
                      lastDate: DateTime.now());
                  setState(() {
          
                  });
                },
                child: Container(
                    width: double.infinity,
                    height: 53,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 1,
                        color: Colors.indigo,
                      ),
                    ),
                    child: Center(
                        child: Text(
                          df.format(selectedDateTime ?? DateTime.now()),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()async {
                var prefs = await SharedPreferences.getInstance();
                int uid = prefs.getInt("user_id") ?? 0;
                ///implement same with Bloc
                context.read<ExpenseBloc>().add(AddExpenseEvent(newExpense: ExpensesModel(
                    uid: uid,
                    amt: double.parse(amtController.text),
                    bal: 0,
                    cid: AppConstant.mCat[selectedCatIndex].cid,
                    title: titleController.text,
                    desc: descController.text,
                    exp_type: selectedType,
                    created_at: (selectedDateTime ?? DateTime.now()).millisecondsSinceEpoch.toString())));
                /* db.addExpense(expense: ExpensesModel(
                    uid: uid,
                    amt: double.parse(amtController.text),
                    bal: 0,
                    cid: AppConstant.mCat[selectedCatIndex].cid,
                    title: titleController.text,
                    desc: descController.text,
                    exp_type: selectedType,
                    created_at: (selectedDateTime ?? DateTime.now()).millisecondsSinceEpoch.toString())); */
                Navigator.pop(context);
          
              }, child: Text("Add Expenses")),
            ],
          ),
        ),
      ),
    );
  }
}

Widget selected_expense({required img, required cat}) {
   return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(img),
        SizedBox(width: 10,),
        Text(cat,style: TextStyle(fontSize: 16)),
      ],
    );


}