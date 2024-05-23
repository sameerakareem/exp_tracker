import 'package:equatable/equatable.dart';

import '../../models/expenses_model.dart';


abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends ExpenseEvent {}

class SubmitExpense extends ExpenseEvent {
  final ExpenseModel expense;

  const SubmitExpense(this.expense);

  @override
  List<Object> get props => [expense];
}

class UpdateType extends ExpenseEvent {
  final String type;

  const UpdateType(this.type);

  @override
  List<Object> get props => [type];
}

class UpdateDate extends ExpenseEvent {
  final DateTime date;

  const UpdateDate(this.date);

  @override
  List<Object> get props => [date];
}
