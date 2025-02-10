import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/d_chart.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/local/models/expense_filter_model.dart';
import 'bloc/expense_bloc.dart';



class StatisticPages extends StatefulWidget {
  @override
  State<StatisticPages> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPages> {

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchFilteredExpense(type: 0));
  }

  String dprdown = 'Date wise';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Statistic",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  DropdownButton<String>(
                    value: "This month",
                    onChanged: (String? newValue) {},
                    items: <String>["This month", "Last month", "This week"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
          
              // Total Expense Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF727DD6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total expense",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text("\$3,734 / \$5000 per month",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.white38,
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
          
              // Expense Breakdown Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Expense Breakdown",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: dprdown,
                    onChanged: (String? newValue) {
                      int selectedTypes=0;
                      if(newValue=="Date wise"){
                        selectedTypes=0;
                      } else if(newValue=="Month wise"){
                        selectedTypes=1;
                      } else if(newValue=="Category wise"){
                        selectedTypes=3;
                      } else {
                        selectedTypes=2;
                      }
                      context.read<ExpenseBloc>().add(FetchFilteredExpense(type: selectedTypes));
          
                      setState(() {
                        dprdown = newValue!;
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
                ],
              ),
              const SizedBox(height: 10),
          
              ///bar chart
              BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state is ExpenseFilterLoadedState) {
                    if(dprdown=='Year wise') {
                        List<OrdinalGroup> mGroupList = [];
                        List<OrdinalData> mList = [];
          
                        for(ExpenseFilterModel eachFilterModel in state.mFilteredExpenses){
                        mList.add(OrdinalData(domain: eachFilterModel.type, measure: eachFilterModel.balance*-1));
                        }
          
                        OrdinalGroup singleData = OrdinalGroup(id: "1", data: mList);
                        mGroupList.add(singleData);
                        return showcharts(dprdown,mGroupList);
                    }
                    else if(dprdown=='Category wise') {
                      List<OrdinalGroup> mGroupList = [];
                      List<OrdinalData> mList = [];

                      for(ExpenseFilterModel eachFilterModel in state.mFilteredExpenses){
                        mList.add(OrdinalData(domain: eachFilterModel.type, measure: eachFilterModel.balance*-1));
                      }

                      OrdinalGroup singleData = OrdinalGroup(id: "1", data: mList);
                      mGroupList.add(singleData);
                      return showcharts(dprdown,mList);
                    }
                    else if(dprdown=='Month wise') {
                      List<TimeGroup> mGroupList = [];
                      List<TimeData> mList = [];
          
                      for(ExpenseFilterModel eachFilterModel in state.mFilteredExpenses){
                        String date = "${(eachFilterModel.type)} 01";
                        DateTime parseDate = new DateFormat("MMM y").parse(date);
                        var inputDate = DateTime.parse(parseDate.toString());
                        var outputFormat = new DateFormat('yyyy-MM-dd');
                        var outputDate = outputFormat.format(inputDate);
          
                        mList.add(TimeData(domain: DateTime.parse(outputDate), measure: eachFilterModel.balance*-1));
                      }
          
                      TimeGroup singleData = TimeGroup(id: "1", data: mList);
                      mGroupList.add(singleData);
                      return showcharts(dprdown,mGroupList);
                    }
                    else if(dprdown=='Date wise') {
                      List<NumericGroup> mGroupList = [];
                      List<NumericData> mList = [];
          
                      for(ExpenseFilterModel eachFilterModel in state.mFilteredExpenses){
          
                        String date = eachFilterModel.type;
                        DateTime parseDate = new DateFormat("MMM d, y").parse(date);
                        var inputDate = DateTime.parse(parseDate.toString());
                        var outputFormat = new DateFormat('dd');
                        var outputDate = outputFormat.format(inputDate);
                        mList.add(NumericData(domain: int.parse(outputDate.toString()), measure: eachFilterModel.balance*-1));
                      }
          
                      NumericGroup singleData = NumericGroup(id: "1", data: mList);
                      mGroupList.add(singleData);
                      return showcharts(dprdown,mGroupList);
                    }
          
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              // Spending Details Section
              Text("Spending Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                "Your expenses are divided into 6 categories",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
          
              // Categories Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpendingCard(
                    color: Colors.purpleAccent,
                    icon: Icons.shopping_bag,
                    title: "Shop",
                    amount: "-\$1190",
                  ),
                  SpendingCard(
                    color: Colors.orangeAccent,
                    icon: Icons.directions_bus,
                    title: "Transport",
                    amount: "-\$867",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget showcharts(String type,mGroupList) {
  if(type=='Month wise') {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 15 / 10,
        child: DChartLineT(
            configRenderLine: ConfigRenderLine(
              strokeWidthPx: 2.5,
            ),
            layoutMargin: LayoutMargin(40, 10, 20, 10),
            domainAxis: DomainAxis(
              showLine: false,
              tickLength: 0,
              gapAxisToLabel: 10,
              tickLabelFormatterT: (domain) {
                return DateFormat('MMM y').format(domain);
              },
              labelStyle: const LabelStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
      groupList: mGroupList),),
    );
  }
  else if(type=='Year wise') {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: DChartBarO(
          //configRenderBar: ConfigRenderBar(
          //  barGroupInnerPaddingPx: 0,
          //  radius: 6,
          //),
          //measureAxis: MeasureAxis(
          // showLine: true,
          // ),
          //animate: true,
          //vertical: true,
            domainAxis: DomainAxis(
              showLine: true,
              tickLength: 0,
              gapAxisToLabel: 20,
              labelStyle: LabelStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),),
            groupList: mGroupList),
      ),
    );
  }
  else if(type=='Category wise') {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 9 / 9,
        child: DChartPieO(
            data: mGroupList,
            customLabel: (ordinalData, index) {
              return '${ordinalData.domain} ${ordinalData.measure}%';
            },
            configRenderPie: ConfigRenderPie(
              strokeWidthPx: 2,
              arcLabelDecorator: ArcLabelDecorator(),
            ),
            ),
      ),
    );
  }
  else if(type=='Date wise') {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AspectRatio(
    aspectRatio: 15 / 10,
    child: DChartScatterN(
        layoutMargin: LayoutMargin(52, 20, 20, 30),
        configRenderPoint: const ConfigRenderPoint(
          radiusPx: 5,
        ),
    domainAxis: DomainAxis(
    showLine: true,
    tickLength: 0,
    gapAxisToLabel: 20,
    labelStyle: LabelStyle(
    color: Colors.grey.shade400,
    fontWeight: FontWeight.bold,
    fontSize: 10,
    ),),
    groupList: mGroupList),
    ),
    );
  }
  else {
    return Container();
  }
}

class SpendingCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String amount;

  const SpendingCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
          Icon(icon, size: 36, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}