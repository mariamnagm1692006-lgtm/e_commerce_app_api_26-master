
import 'dart:convert';
import 'package:ecommerce_app_api_26/core/endpoint/end_point.dart';
import 'package:ecommerce_app_api_26/core/storage/storage_helper.dart';
import 'package:http/http.dart' as http;

import '../models/profile_error_model.dart';
import '../models/profile_model.dart';
class ProfileApi {
  Future<ProfileModel>getProfile()async{
    Uri url=Uri.parse(EndPoint.baseurl+EndPoint.profile);
    String? token=await StorageHelper.getToken();
   var response=await http.get(url,
    headers: {
      "Authorization":"Bearer $token"
    }
    );
    var json=jsonDecode(response.body);
    if(response.statusCode==200||response.statusCode==201){
      ProfileModel profileModel=ProfileModel.fromJson(json);
      return profileModel;
    }
    else{
      ProfileErrorModel profileErrorModel=ProfileErrorModel.fromJson(json);
      throw Exception(profileErrorModel.message);
    }
  }
}
