import 'package:expence_tracker/models/expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ExpenseProvider extends ChangeNotifier {
  List<ExpenseModel> _expenseModel = [];
  ExpenseDao _expenseDao = ExpenseDao();

  List<ExpenseModel> get expenseModel => _expenseModel;

  Future<void> fetchExpenses() async {
    _expenseModel = await _expenseDao.getExpenses();
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    await _expenseDao.deleteExpense(id);
    _expenseModel.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  Future<void> updateExpense(ExpenseModel updatedExpense) async {
    await _expenseDao.updateExpense(
      updatedExpense.id!,
      updatedExpense.amount!,
    );
    await fetchExpenses();
  }

  void setLines(List<ExpenseModel> newList) {
    _expenseModel = newList;
    notifyListeners();
  }

  void addLine(ExpenseModel newLine) {
    _expenseModel.add(newLine);
    notifyListeners();
  }
}

class ExpenseHistory extends StatefulWidget {
  const ExpenseHistory({super.key});
  @override
  ExpenseListData createState() => ExpenseListData();
}

class ExpenseListData extends State<ExpenseHistory> {
  List<ExpenseModel> expenseModel = [];
  ExpenseDao expenseDao = ExpenseDao();

  @override
  void initState() {
    super.initState();
    getSavedData();
  }

  Future<void> getSavedData() async {
    expenseModel = await expenseDao.getExpenses();
    Provider.of<ExpenseProvider>(context, listen: false)
        .setLines(expenseModel!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense History"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: _buildView_1(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildView_1() {
    if (expenseModel != null && expenseModel!.isNotEmpty) {
      return Consumer<ExpenseProvider>(
          builder: (context, expenseProvider, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: expenseProvider.expenseModel.length,
          itemBuilder: (BuildContext context, int x) {
            ExpenseModel expense = expenseProvider.expenseModel[x];
            return GestureDetector(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            expense.categoryName!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Spacer(),
                          Text(
                            expense.amount!.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            expense.date!,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showEditQuantityDialog(context, expense);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, expense);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
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

  Future<void> onDelete(ExpenseModel model) async {
    await expenseDao.deleteExpense(model.id!);
    setState(() {});
  }

  void showEditQuantityDialog(BuildContext context, ExpenseModel model) {
    TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Quantity'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Enter quantity"),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                String qty = quantityController.text;
                model.amount = int.tryParse(qty);
                Provider.of<ExpenseProvider>(context, listen: false)
                    .updateExpense(model);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, ExpenseModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("You want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ExpenseProvider>(context, listen: false)
                    .deleteExpense(model.id!);
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> onEdit() async {
    expenseModel = await expenseDao.getExpenses();
    setState(() {});
  }
}
