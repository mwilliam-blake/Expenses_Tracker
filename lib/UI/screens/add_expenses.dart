import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/app_constants.dart';

class AddExpensePage extends StatefulWidget{

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  TextEditingController amtController = TextEditingController();

  List<String> mType = ["Debit", "Credit", "Loan", "Borrow", "Lend"];

  String selectedType = "Debit";

  Widget botm_scfol = Center(child: Text("Choose a Category", style: TextStyle(fontSize: 16),));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            )

          ],
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