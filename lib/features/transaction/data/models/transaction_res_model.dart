// To parse this JSON data, do
//
//     final transactionsResponseModel = transactionsResponseModelFromJson(jsonString);

import 'dart:convert';

TransactionsResponseModel transactionsResponseModelFromJson(String str) => TransactionsResponseModel.fromJson(json.decode(str));

String transactionsResponseModelToJson(TransactionsResponseModel data) => json.encode(data.toJson());

class TransactionsResponseModel {
  final int status;
  final String msg;
  final String description;
  final Transactions transactions;

  TransactionsResponseModel({
    required this.status,
    required this.msg,
    required this.description,
    required this.transactions,
  });

  TransactionsResponseModel copyWith({
    int? status,
    String? msg,
    String? description,
    Transactions? transactions,
  }) =>
      TransactionsResponseModel(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        description: description ?? this.description,
        transactions: transactions ?? this.transactions,
      );

  factory TransactionsResponseModel.fromJson(Map<String, dynamic> json) => TransactionsResponseModel(
    status: json["status"],
    msg: json["msg"],
    description: json["description"],
    transactions: Transactions.fromJson(json["transactions"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "description": description,
    "transactions": transactions.toJson(),
  };
}

class Transactions {
  final int total;
  final List<Transaction> transactions;

  Transactions({
    required this.total,
    required this.transactions,
  });

  Transactions copyWith({
    int? total,
    List<Transaction>? transactions,
  }) =>
      Transactions(
        total: total ?? this.total,
        transactions: transactions ?? this.transactions,
      );

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
    total: json["total"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  final int id;
  final String transactionNo;
  final int type;
  final String amount;
  final DateTime transactionDate;
  final String details;
  final String billNo;
  final String? image;
  final String? imageFullPath;
  final int status;

  Transaction({
    required this.id,
    required this.transactionNo,
    required this.type,
    required this.amount,
    required this.transactionDate,
    required this.details,
    required this.billNo,
    required this.image,
    required this.imageFullPath,
    required this.status,
  });

  Transaction copyWith({
    int? id,
    String? transactionNo,
    int? type,
    String? amount,
    DateTime? transactionDate,
    String? details,
    String? billNo,
    String? image,
    String? imageFullPath,
    int? status,
  }) =>
      Transaction(
        id: id ?? this.id,
        transactionNo: transactionNo ?? this.transactionNo,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        transactionDate: transactionDate ?? this.transactionDate,
        details: details ?? this.details,
        billNo: billNo ?? this.billNo,
        image: image ?? this.image,
        imageFullPath: imageFullPath ?? this.imageFullPath,
        status: status ?? this.status,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    transactionNo: json["transaction_no"],
    type: json["type"],
    amount: json["amount"],
    transactionDate: DateTime.parse(json["transaction_date"]),
    details: json["details"],
    billNo: json["bill_no"],
    image: json["image"],
    imageFullPath: json["image_full_path"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_no": transactionNo,
    "type": type,
    "amount": amount,
    "transaction_date": transactionDate.toIso8601String(),
    "details": details,
    "bill_no": billNo,
    "image": image,
    "image_full_path": imageFullPath,
    "status": status,
  };
}
