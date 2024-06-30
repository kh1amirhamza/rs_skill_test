import 'dart:convert';

import 'package:http/http.dart' as http;

class SSLCommerzService {
  final String storeId;
  final String storePassword;

  SSLCommerzService({required this.storeId, required this.storePassword});

  Future<Map<String, dynamic>> initiatePayment({
    required String amount,
    required String currency,
    required String tranId,
    required String successUrl,
    required String failUrl,
    required String cancelUrl,
    required String cusName,
    required String cusEmail,
    required String cusPhone,
    required String cusAdd1,
    required String cusCity,
    required String cusCountry,
  }) async {
    final url =
        Uri.parse("https://sandbox.sslcommerz.com/gwprocess/v4/api.php");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'store_id': storeId,
        'store_passwd': storePassword,
        'total_amount': amount,
        'currency': currency,
        'tran_id': tranId,
        'success_url': successUrl,
        'fail_url': failUrl,
        'cancel_url': cancelUrl,
        'cus_name': cusName,
        'cus_email': cusEmail,
        'cus_phone': cusPhone,
        'cus_add1': cusAdd1,
        'cus_city': cusCity,
        'cus_country': cusCountry,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to initiate payment');
    }
  }
}
