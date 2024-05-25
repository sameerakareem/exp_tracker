
import 'package:equatable/equatable.dart';

class RegistrationState extends Equatable {
  final String name;
  final String password;
  final String phone;
  final String email;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const RegistrationState({
    required this.name,
    required this.password,
    required this.phone,
    required this.email,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory RegistrationState.initial() {
    return const RegistrationState(
      name: '',
      password: '',
      phone: '',
      email: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegistrationState copyWith({
    String? name,
    String? password,
    String? phone,
    String? email,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegistrationState(
      name: name ?? this.name,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props => [name, password, phone, email, isSubmitting, isSuccess, isFailure];
}
