import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../models/profile_model.dart';
import '../../utils/app_controller.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserDetailsDao userDetailsDao;

  LoginBloc({required this.userDetailsDao}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      // Simulate a delay for the login process
      await Future.delayed(const Duration(seconds: 2));

      ProfileModel? selectedProfile =
      await userDetailsDao.getUserByCredentials(event.username, event.password);

      if (selectedProfile != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: "Username or password is incorrect"));
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
