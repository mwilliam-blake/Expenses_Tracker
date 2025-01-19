import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Map<String, dynamic>> expenses = [
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
  ];



  String selectedFilter = "This month";

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
                        setState(() {
                          selectedFilter = newValue!;
                        });
                      },
                      items: <String>["This month", "Last month", "This week"]
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
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (_, index) {
                    var expense = expenses[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(expense["date"],
                                    style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black87)),
                                Text("\$ ${expense["amount"]}", style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: expense["amount"] < 0
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
                                itemCount: expenses[index]['sublist'].length,
                                itemBuilder: (_, indx) {
                                  dynamic subexp = expenses[index]['sublist'][indx];
        
                                  return
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                      children: [
                                      Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      child: Icon(subexp['icon'], color: Colors.white,),
                                      decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent.shade100,
                                      borderRadius: BorderRadius.circular(5),
                                      ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text(subexp['title'],style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      Text(subexp['desc'],style: TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                      ),
                                      ],),
                                          Text("\$ ${subexp["samount"]}",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: expense["amount"] < 0 ? Colors.red.shade300 : Colors.green.shade300,)),
                                        ],
                                      );
                                },),),
                          ],
                        ),
                      );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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