import 'dart:convert';

import 'package:rs_skill_test/features/branch/data/models/branch_res_model.dart';

import '../../../../core/services/api_client_implemnt.dart';

class BranchRepo{
  final apiClient = APIClintImpl();

  Future<BranchResponseModel?> getBranches() async {
    dynamic response =
    await apiClient.get('/admin/branches');
    return response == null ? null : BranchResponseModel.fromJson(response);
  }

  Future<String?> createBranch(body) async {
    dynamic response = await apiClient.post('/admin/branch/create', data: jsonEncode(body));
    return response == null ? null : response['msg'];
  }

  Future<String?> updateBranch(body, String branchId) async {
    dynamic response = await apiClient.post('/admin/branch/$branchId/update', data: jsonEncode(body));
    return response == null ? null : response['msg'];
  }

  Future<String?> deleteBranch( String branchId) async {
    dynamic response = await apiClient.delete('/admin/branch/$branchId/delete');
    return response == null ? null : response['msg'];
  }

}