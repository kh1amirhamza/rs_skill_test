import 'dart:convert';

import 'package:rs_skill_test/features/transaction/data/models/transaction_res_model.dart';

import '../../../../core/services/api_client_implemnt.dart';

class TransactionsRepo{
  final apiClient = APIClintImpl();

  Future<TransactionsResponseModel?> getTransactions(String branchID, String customerID) async {
    dynamic response =
    await apiClient.get('/admin/$branchID/customer/$customerID/transactions');
    return response == null ? null : TransactionsResponseModel.fromJson(response);
  }

  Future<String?> createTransaction(body,String branchID, Map<String, dynamic> keyAndFilePaths) async {
    dynamic response = await apiClient.uploadFiles('/admin/$branchID/customer/transaction/create', data: body, keysAndFilePaths: keyAndFilePaths);
    return response == null ? null : response['description'];
  }

  Future<String?> updateTransaction(body, String branchId, String transactionId, Map<String, dynamic>? keyAndFilePaths) async {
    dynamic response = await apiClient.uploadFiles('/admin/$branchId/customer/transaction/$transactionId/update', data: body, keysAndFilePaths: keyAndFilePaths);
    return response == null ? null : response['description'];
  }
  Future<String?> deleteTransaction(String branchId, String transactionId) async {
    dynamic response = await apiClient.delete('/admin/$branchId/customer/transaction/$transactionId/delete');
    return response == null ? null : response['msg'];
  }

}