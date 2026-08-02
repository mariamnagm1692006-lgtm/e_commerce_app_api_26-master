import 'package:ecommerce_app_api_26/features/auth/data/cubit_login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_api/auth_api.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  AuthApi authApi = AuthApi();
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await authApi.login(email: email, Password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
