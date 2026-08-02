import 'package:ecommerce_app_api_26/features/auth/data/auth_api/auth_api.dart';
import 'package:ecommerce_app_api_26/features/auth/data/cubit_signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthApi authApi = AuthApi();
  SignupCubit() : super(SignupInitial());
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      await authApi.signup(name: name, email: email, password: password);
      print("API Success");
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }
}
