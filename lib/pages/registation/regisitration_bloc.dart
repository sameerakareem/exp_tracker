// registration_bloc.dart

import 'package:expence_tracker/pages/registation/regisitration_event.dart';
import 'package:expence_tracker/pages/registation/regisitration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/profile_model.dart';
import '../../utils/constants.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserDetailsDao profileDao;

  RegistrationBloc(this.profileDao) : super(RegistrationState.initial()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<FormSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isSuccess: false, isFailure: false));

      try {
        ProfileModel profile = ProfileModel(
          userName: state.name,
          password: state.password,
          phone: state.phone,
          email: state.email,
        );

        await profileDao.insert(profile);

        emit(state.copyWith(isSubmitting: false, isSuccess: true, isFailure: false));
      } catch (error) {
        emit(state.copyWith(isSubmitting: false, isSuccess: false, isFailure: true));
      }
    });
  }
}
