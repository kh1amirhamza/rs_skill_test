import 'dart:convert';

import '../../../../core/services/api_client_implemnt.dart';
import '../models/sign_up_res_model.dart';

class SignUpRepository {
  final apiClient = APIClintImpl();

  Future<int?> registration(body) async {
    dynamic response =
        await apiClient.post('/sign-up/store', data: jsonEncode(body));
    return response == null ? null : response['identifier_id'];
  }

  Future<String?> resendOtp(body) async {
    dynamic response = await apiClient.post('/sign-up/send-otp-code', data: jsonEncode(body));
    return response == null ? null : response['description'];
  }

  Future<SignUpResponseModel?> verifyOtp(body) async {
    dynamic response = await apiClient.post('/sign-up/verify-otp-code', data: jsonEncode(body));
    return response == null ? null : SignUpResponseModel.fromJson(response['response_user']);//response['description'];
  }
}
