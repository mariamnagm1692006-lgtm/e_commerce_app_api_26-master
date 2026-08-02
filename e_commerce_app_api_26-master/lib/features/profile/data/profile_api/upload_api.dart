import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/endpoint/end_point.dart';
import '../models/upload_error_model.dart';
import '../models/upload_model.dart';

class UploadApi {
  Future<UploadModel> uploadImage(String path) async {
    /// هتاخد ال path بتاع الصوره من الايميلتور وتعملنا request
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(EndPoint.baseurl + EndPoint.upload),
    );

    request.files.add(
      ///بحول ال path بتاع الصوره لMultipartFile عشان اقدر ابعته للسيرفر عشان هو مش بيقدر يقرأ عنوان الصوره
      await http.MultipartFile.fromPath("file", path),
    );

    var response = await request.send();

    var responseData = jsonDecode(await response.stream.bytesToString());
    print("Status Code = ${response.statusCode}");
    print("Response = $responseData");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UploadModel.fromJson(responseData);
    } else {
      UploadErrorModel error = UploadErrorModel.fromJson(responseData);

      throw Exception(error.message);
    }
  }
}
