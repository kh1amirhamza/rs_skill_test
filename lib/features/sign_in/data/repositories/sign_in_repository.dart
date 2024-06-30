import 'dart:convert';

import 'package:rs_skill_test/features/sign_in/data/models/login_res_model.dart';

import '../../../../core/services/api_client_implemnt.dart';


class SignInRepository {
  final apiClient = APIClintImpl();

  Future<String?> sendLogInOtp(body) async {
    dynamic response = await apiClient.post('/send-login-otp', data: jsonEncode(body));
    return response == null ? null : response['message'];
  }

  Future<LogInResponseModel?> logIn(body) async {
    dynamic response = await apiClient.post('/login', data: jsonEncode(body));
    return response == null ? null : logInResponseModelFromJson(jsonEncode(response));//response['description'];
  }
}
