// To parse this JSON data, do
//
//     final customerSupplierResModel = customerSupplierResModelFromJson(jsonString);

import 'dart:convert';

CustomerSupplierResModel customerSupplierResModelFromJson(String str) => CustomerSupplierResModel.fromJson(json.decode(str));

String customerSupplierResModelToJson(CustomerSupplierResModel data) => json.encode(data.toJson());

class CustomerSupplierResModel {
  final int status;
  final String msg;
  final String description;
  final Customers customers;

  CustomerSupplierResModel({
    required this.status,
    required this.msg,
    required this.description,
    required this.customers,
  });

  CustomerSupplierResModel copyWith({
    int? status,
    String? msg,
    String? description,
    Customers? customers,
  }) =>
      CustomerSupplierResModel(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        description: description ?? this.description,
        customers: customers ?? this.customers,
      );

  factory CustomerSupplierResModel.fromJson(Map<String, dynamic> json) => CustomerSupplierResModel(
    status: json["status"],
    msg: json["msg"],
    description: json["description"],
    customers: Customers.fromJson(json["customers"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "description": description,
    "customers": customers.toJson(),
  };
}

class Customers {
  final int total;
  final List<Customer> customers;

  Customers({
    required this.total,
    required this.customers,
  });

  Customers copyWith({
    int? total,
    List<Customer>? customers,
  }) =>
      Customers(
        total: total ?? this.total,
        customers: customers ?? this.customers,
      );

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
    total: json["total"],
    customers: List<Customer>.from(json["customers"].map((x) => Customer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
  };
}

class Customer {
  final int id;
  final String name;
  final String phone;
  final String balance;
  int? type;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.balance,
     this.type,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? phone,
    String? balance,
    int? type,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        balance: balance ?? this.balance,
        type: type ?? this.type,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "balance": balance,
  };
}
