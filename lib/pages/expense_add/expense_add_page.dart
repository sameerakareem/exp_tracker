import 'package:expence_tracker/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/category_model.dart';
import '../../models/expenses_model.dart';
import '../../utils/constants.dart';
import '../home.dart';
import 'expense_add_bloc.dart';
import 'expense_add_event.dart';
import 'expense_add_state.dart';



class ExpenseEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseBloc(CategoryDao(), ExpenseDao())
        ..add(LoadCategories()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Expense Entry'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpenseEntryForm(),
          ),
        ),
      ),
    );
  }
}

class ExpenseEntryForm extends StatefulWidget {
  @override
  _ExpenseEntryFormState createState() => _ExpenseEntryFormState();
}

class _ExpenseEntryFormState extends State<ExpenseEntryForm> {
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String? selectedCategoryName;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state.submissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Expense saved successfully')),
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Home(),
          ));
        }
      },
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          // Set the initial selected category name
          if (state.categories.isNotEmpty) {
            selectedCategoryName = state.categories[0].name ?? '';
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ToggleButtons(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: Text('Income')),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: Text('Expense')),
                        ),
                      ],
                      isSelected: [
                        state.selectedType == 'Income',
                        state.selectedType == 'Expense'
                      ],
                      onPressed: (int index) {
                        context.read<ExpenseBloc>().add(
                          UpdateType(index == 0 ? 'Income' : 'Expense'),
                        );
                      },
                      fillColor:
                      Theme.of(context).primaryColor.withOpacity(0.2),
                      selectedColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                      constraints: BoxConstraints.expand(
                          width: MediaQuery.of(context).size.width / 2 - 32),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date: ${DateFormat('dd-MM-yyyy').format(state.selectedDate)}'),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Choose Date'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: noteController,
                        decoration: InputDecoration(
                          labelText: "Note",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<CategoryModel>(
                value: state.categories.isNotEmpty ? state.categories[0] : null,
                items: state.categories.map((CategoryModel category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.name ?? ''),
                  );
                }).toList(),
                onChanged: (CategoryModel? value) {
                  if (value != null) {
                    selectedCategoryName = value.name;
                  }
                },
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  height: defaultButtonSize,
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      _submit(context);
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.all(8),
                    ),
                    child: Text(
                      "Save",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: context.read<ExpenseBloc>().state.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      context.read<ExpenseBloc>().add(UpdateDate(selectedDate));
    }
  }

  void _submit(BuildContext context) {
    final state = context.read<ExpenseBloc>().state;
    final expenseModel = ExpenseModel(
      type: state.selectedType,
      date: DateFormat('dd-MM-yyyy').format(state.selectedDate),
      amount: int.parse(amountController.text), // Convert the string to a double
      categoryName: selectedCategoryName,
      Note: noteController.text,
    );

    context.read<ExpenseBloc>().add(SubmitExpense(expenseModel));
  }

}
