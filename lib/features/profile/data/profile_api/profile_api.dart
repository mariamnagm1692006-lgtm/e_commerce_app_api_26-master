import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app_api_26/core/api/end_points.dart';
import 'package:ecommerce_app_api_26/core/storage/storage_helper.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/avatar_model.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/profile_error_model.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileApi {
  Future<ProfileModel> getProfile() async {
    Uri url = Uri.parse(EndPoints.baseUrl+EndPoints.profile);

    String? token = await StorageHelper.getToken();

    var response = await http.get(
      url,
      headers: {
        "Authorization":"Bearer $token"
      }
    );
    var json = jsonDecode(response.body);
    if(response.statusCode==200||response.statusCode==201){
      ProfileModel profileModel =ProfileModel.fromJson(json);
      return profileModel;
    }else{
      ProfileErrorModel errorModel =ProfileErrorModel.fromJson(json);
      throw Exception(errorModel.message);
    }
  }

  Future<AvatarModel> uploadImage(File imageFile) async {
    Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.uploadFile);

    var request = http.MultipartRequest('POST', url);

    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      return AvatarModel.fromJson(jsonResponse);
    } else {
      throw Exception('upload failed');
    }
  }

  Future<void> updateProfileAvatar(int userId, String newImageUrl) async {
    Uri url = Uri.parse('${EndPoints.baseUrl}users/$userId');

    var response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "avatar": newImageUrl, // بنحدث الصورة بس
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('update failed');
    }
  }
}