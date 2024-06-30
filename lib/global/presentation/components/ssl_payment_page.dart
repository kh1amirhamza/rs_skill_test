import 'dart:convert';

import 'package:flutter/material.dart';

import '../../services/sslcommerz_service.dart';

class SSLCommerzPaymentPage extends StatefulWidget {
  const SSLCommerzPaymentPage({super.key});

  @override
  State<SSLCommerzPaymentPage> createState() => _SSLCommerzPaymentPageState();
}

class _SSLCommerzPaymentPageState extends State<SSLCommerzPaymentPage> {
  final SSLCommerzService _sslCommerzService = SSLCommerzService(
    storeId: 'arobi6370cc3e01ee8',
    storePassword: 'arobi6370cc3e01ee8@ssl',
  );

  void _initiatePayment() async {
    try {
      final response = await _sslCommerzService.initiatePayment(
        amount: '100.0',
        currency: 'BDT',
        tranId: 'tran1234',
        successUrl: 'your_success_url',
        failUrl: 'your_fail_url',
        cancelUrl: 'your_cancel_url',
        cusName: 'John Doe',
        cusEmail: 'john.doe@example.com',
        cusPhone: '01700000000',
        cusAdd1: 'Address Line 1',
        cusCity: 'Dhaka',
        cusCountry: 'Bangladesh',
      );

      print("response: ${jsonEncode(response)}");

      if (response['status'] == 'SUCCESS') {
        final paymentUrl = response['GatewayPageURL'];
        // Open the payment URL in a webview or browser
        // Implement this part as per your requirement
      } else {
        // Handle the failure
      }
    } catch (e) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _initiatePayment,
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}
