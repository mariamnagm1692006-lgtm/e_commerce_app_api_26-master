import 'dart:convert';

import 'package:ecommerce_app_api_26/features/auth/data/models/token_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/endboint/end_boint.dart';
import '../models/error_model.dart';

class AuthApi {
  ///login
  Future<Tokenmodel> login(
      {required String email, required String Password}) async {
    Uri url = Uri.parse(Endboint.baseurl + Endboint.login);
    Map<String, dynamic> RequestBody = {
      ApiKeys.email: email,
      ApiKeys.password: Password,
    };
    var response = await http.post(
      url,
      body: jsonEncode(RequestBody),
      headers: {"Content-Type": "application/json"},
    );

    String requestBody = response.body;
    var json = jsonDecode(requestBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Tokenmodel tokenmodel = Tokenmodel.fromJson(json);
      return tokenmodel;
    } else {
      ErrorToken errorToken = ErrorToken.fromJson(json);
      throw Exception(errorToken.message);
    }
  }

  ///Signup
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    })async{
    Uri url = Uri.parse(Endboint.baseurl + Endboint.signup);
    Map<String, dynamic> RequestBody = {
      ApiKeys.name:name,
      ApiKeys.email: email,
      ApiKeys.password: password,
      ApiKeys.avatar:"https://api.lorem.space/image/face?w=640&h=480",
    };
    var response = await http.post(
      url,
      body: jsonEncode(RequestBody),
      headers: {"Content-Type": "application/json"},
    );
    String requestBody = response.body;
    var json = jsonDecode(requestBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel userModel = UserModel.fromJson(json);
      return userModel;
    } else {
      ErrorToken errorToken = ErrorToken.fromJson(json);
      throw Exception(errorToken.message);
    }
    }

  }


