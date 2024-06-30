import 'dart:convert';

import 'package:rs_skill_test/features/profile/data/models/business_type_res_model.dart';
import 'package:rs_skill_test/features/profile/data/models/profile_res_model.dart';
import '../../../../core/services/api_client_implemnt.dart';

class ProfileRepo{
  final apiClient = APIClintImpl();

  Future<ProfileResponseModel?> getProfile() async {
    dynamic response =
    await apiClient.get('/admin/profile');
    return response == null ? null : ProfileResponseModel.fromJson(response);
  }

  Future<String?> updateProfile(body, Map<String, dynamic>? keyAndFilePaths) async {
    dynamic response = await apiClient.uploadFiles('/admin/profile/update', data: body, keysAndFilePaths: keyAndFilePaths);
    return response == null ? null : response['description'];
  }

  Future<BusinessTypeResModel?> getBusinessTypes() async {
    dynamic response = await apiClient.get('/get-business-types');
    return response == null ? null : BusinessTypeResModel.fromJson(response);
  }
}