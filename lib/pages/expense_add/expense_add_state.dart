import 'package:equatable/equatable.dart';

import '../../models/category_model.dart';

class ExpenseState extends Equatable {
  final List<CategoryModel> categories;
  final String selectedType;
  final DateTime selectedDate;
  final bool isSubmitting;
  final bool submissionSuccess;

  ExpenseState({
    this.categories = const [],
    this.selectedType = 'Expense',
    DateTime? selectedDate,
    this.isSubmitting = false,
    this.submissionSuccess = false,
  }) : selectedDate = selectedDate ?? DateTime.now();

  @override
  List<Object> get props => [
    categories,
    selectedType,
    selectedDate,
    isSubmitting,
    submissionSuccess,
  ];

  ExpenseState copyWith({
    List<CategoryModel>? categories,
    String? selectedType,
    DateTime? selectedDate,
    bool? isSubmitting,
    bool? submissionSuccess,
  }) {
    return ExpenseState(
      categories: categories ?? this.categories,
      selectedType: selectedType ?? this.selectedType,
      selectedDate: selectedDate ?? this.selectedDate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
    );
  }
}
