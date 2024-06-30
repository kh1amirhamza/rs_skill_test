import 'dart:convert';

import 'package:rs_skill_test/features/customer_suplier/data/models/customer_supplier_res_model.dart';

import '../../../../core/services/api_client_implemnt.dart';

class CustomerSupplierRepo{
  final apiClient = APIClintImpl();

  Future<CustomerSupplierResModel?> getCustomerSupplier(String branchID, String userType) async {
    dynamic response =
    await apiClient.get('/admin/$branchID/$userType/customers');
    return response == null ? null : CustomerSupplierResModel.fromJson(response);
  }

  Future<String?> createCustomerSupplier(body,String branchID, Map<String, dynamic>? keyAndFilePaths) async {
    dynamic response = await apiClient.uploadFiles('/admin/$branchID/customer/create', data: body, keysAndFilePaths: keyAndFilePaths);
    return response == null ? null : response['description'];
  }

  Future<String?> updateCustomerSupplier(body, String branchId, String userId) async {
    dynamic response = await apiClient.post('/admin/$branchId/customer/$userId/update', data: jsonEncode(body));
    return response == null ? null : response['msg'];
  }

  Future<String?> deleteCustomerSupplier(String branchId, String userId) async {
    dynamic response = await apiClient.delete('/admin/$branchId/customer/$userId/delete');
    return response == null ? null : response['description'];
  }


}