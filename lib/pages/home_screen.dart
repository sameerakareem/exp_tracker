import 'dart:convert';

import 'package:expence_tracker/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/expenses_model.dart';
import 'expense_add/expense_add_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  CategoryDao categoryDao = CategoryDao();
  ExpenseDao expenseDao = ExpenseDao();
  late double totalAmount = 0;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  List<CategoryModel> categoryList = [];
  List<ExpenseModel> expenseModel = [];
  List<ExpenseModel> incomeModel = [];
  String? selectedType = "daily";
  bool isLoading = true;
  late String formattedDate;
  late double totalIncome = 0;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('dd-MM-yyyy').format(fromDate);
    getExpense(fromDate);
    setData();
  }

  Future<void> setData() async {
    await categoryDao.deleteAll();
    await categoryDao.insertInitialCategories();
    setState(() {});
    getData();
  }

  Future<void> getData() async {
    categoryList = await categoryDao.getAllCategories();
    totalAmount =
        await expenseDao.getTotalAmountByTypeAndDate("Income", formattedDate);
    totalIncome = totalAmount;
  }

  Future<void> getExpense(DateTime selectedDate) async {
    isLoading = true;
    setState(() {});
    expenseModel = await expenseDao.getExpensesByDate(selectedDate);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense '),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedType = 'daily';
                            DateTime currentDate = DateTime.now();
                            DateTime currentDateOnly = DateTime(
                                currentDate.year,
                                currentDate.month,
                                currentDate.day);
                            fromDate = currentDateOnly;
                            getExpense(fromDate);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: selectedType == 'daily'
                              ? Colors
                                  .green
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: selectedType == 'daily'
                                  ? Colors.black
                                  : Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: const Text('Daily'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedType = 'weekly';
                            DateTime currentDate = DateTime.now();
                            DateTime currentDateOnly = DateTime(
                                currentDate.year,
                                currentDate.month,
                                currentDate.day);
                            DateTime monday = currentDateOnly.subtract(
                                Duration(days: currentDate.weekday - 1));
                            fromDate = monday;
                            getExpense(fromDate);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: selectedType == 'weekly'
                              ? Colors
                                  .green
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            side: BorderSide(
                              color: selectedType == 'weekly'
                                  ? Colors.black
                                  : Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: const Text('Weekly'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedType = 'monthly';
                            DateTime currentDate = DateTime.now();
                            DateTime currentDateOnly = DateTime(
                                currentDate.year,
                                currentDate.month,
                                currentDate.day);
                            fromDate = DateTime(
                                currentDateOnly.year, currentDateOnly.month, 1);
                            getExpense(fromDate);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: selectedType == 'monthly'
                              ? Colors
                                  .green
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: selectedType == 'monthly'
                                  ? Colors.black
                                  : Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: const Text('Monthly'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedType = 'yearly';
                            DateTime currentDate = DateTime.now();
                            DateTime currentDateOnly = DateTime(
                                currentDate.year,
                                currentDate.month,
                                currentDate.day);
                            fromDate = DateTime(currentDateOnly.year, 1, 1);
                            getExpense(fromDate);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: selectedType == 'yearly'
                              ? Colors
                                  .green
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: selectedType == 'yearly'
                                  ? Colors.black
                                  : Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: const Text('Yearly'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height -
                            100,
                        child: _buildView_1(),
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const ExpenseEntryPage(),
            ));
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }

  Widget _buildView_1() {
    getData();
    Map<String, double> dataMap = {};
    double totalExpense = 0;
    for (var expense in expenseModel) {
      if (expense.categoryName != null && expense.amount != null) {
        dataMap[expense.categoryName!] =
            (dataMap[expense.categoryName!] ?? 0) + expense.amount!.toDouble();
        totalExpense += expense.amount!.toDouble();
      }
    }

    double balanceAmount = totalAmount - totalExpense;
    dataMap['Balance'] = balanceAmount;
    bool exceedsTarget =
        balanceAmount < 0; // If balance is negative, it exceeds the target

    double chartHeight = 200.0 + dataMap.length * 20.0;
    if (expenseModel != null && expenseModel!.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Income : $totalAmount",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "Expense : $totalExpense",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: chartHeight,
                child: PieChart(
                  dataMap: dataMap,
                  chartRadius: MediaQuery.of(context).size.width / 2.5,
                  chartType: ChartType.ring,
                  chartLegendSpacing: 32,
                  colorList: Colors.primaries,
                  initialAngleInDegree: 0,
                  ringStrokeWidth: 32,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.bottom,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValues: false,
                    showChartValuesOutside: false,
                    chartValueStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: exceedsTarget,
              child: const Text(
                "Expense exceeds the Income",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: expenseModel.length,
              itemBuilder: (BuildContext context, int x) {
                ExpenseModel expense = expenseModel[x];
                return GestureDetector(
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              expense.categoryName!,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Spacer(),
                            Text(
                              expense.amount!.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Lottie.asset(
                  'assets/images/animations.json',
                  width: 250.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                "No Expense Found!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
      );
    }
  }
}
