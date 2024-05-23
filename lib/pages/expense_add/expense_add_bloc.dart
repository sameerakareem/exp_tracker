import 'package:bloc/bloc.dart';

import '../../models/category_model.dart';
import '../../models/expenses_model.dart';
import 'expense_add_event.dart';
import 'expense_add_state.dart';


class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final CategoryDao categoryDao;
  final ExpenseDao expenseDao;

  ExpenseBloc(this.categoryDao, this.expenseDao) : super( ExpenseState()) {
    on<LoadCategories>(_onLoadCategories);
    on<SubmitExpense>(_onSubmitExpense);
    on<UpdateType>(_onUpdateType);
    on<UpdateDate>(_onUpdateDate);
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<ExpenseState> emit) async {
    final categories = await categoryDao.getAllCategories();
    emit(state.copyWith(categories: categories));
  }

  Future<void> _onSubmitExpense(
      SubmitExpense event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    await expenseDao.insert(event.expense);
    emit(state.copyWith(isSubmitting: false, submissionSuccess: true));
  }

  void _onUpdateType(UpdateType event, Emitter<ExpenseState> emit) {
    emit(state.copyWith(selectedType: event.type));
  }

  void _onUpdateDate(UpdateDate event, Emitter<ExpenseState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }
}
