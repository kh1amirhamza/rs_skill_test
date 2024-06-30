// To parse this JSON data, do
//
//     final logInResponseModel = logInResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LogInResponseModel logInResponseModelFromJson(String str) => LogInResponseModel.fromJson(json.decode(str));

String logInResponseModelToJson(LogInResponseModel data) => json.encode(data.toJson());

class LogInResponseModel {
  final int status;
  final String msg;
  final String description;
  final User user;

  LogInResponseModel({
    required this.status,
    required this.msg,
    required this.description,
    required this.user,
  });

  LogInResponseModel copyWith({
    int? status,
    String? msg,
    String? description,
    User? user,
  }) =>
      LogInResponseModel(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        description: description ?? this.description,
        user: user ?? this.user,
      );

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) => LogInResponseModel(
    status: json["status"],
    msg: json["msg"],
    description: json["description"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "description": description,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String apiToken;
  final String name;
  final String email;
  final String phone;
  final dynamic image;
  final dynamic imageFullPath;
  final String businessName;
  final String businessType;
  final int businessTypeId;
  final String branch;
  final int companyId;
  final int branchId;

  User({
    required this.id,
    required this.apiToken,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.imageFullPath,
    required this.businessName,
    required this.businessType,
    required this.businessTypeId,
    required this.branch,
    required this.companyId,
    required this.branchId,
  });

  User copyWith({
    int? id,
    String? apiToken,
    String? name,
    String? email,
    String? phone,
    dynamic image,
    dynamic imageFullPath,
    String? businessName,
    String? businessType,
    int? businessTypeId,
    String? branch,
    int? companyId,
    int? branchId,
  }) =>
      User(
        id: id ?? this.id,
        apiToken: apiToken ?? this.apiToken,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        imageFullPath: imageFullPath ?? this.imageFullPath,
        businessName: businessName ?? this.businessName,
        businessType: businessType ?? this.businessType,
        businessTypeId: businessTypeId ?? this.businessTypeId,
        branch: branch ?? this.branch,
        companyId: companyId ?? this.companyId,
        branchId: branchId ?? this.branchId,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    apiToken: json["api_token"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    imageFullPath: json["image_full_path"],
    businessName: json["business_name"],
    businessType: json["business_type"],
    businessTypeId: json["business_type_id"],
    branch: json["branch"],
    companyId: json["company_id"],
    branchId: json["branch_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "api_token": apiToken,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "image_full_path": imageFullPath,
    "business_name": businessName,
    "business_type": businessType,
    "business_type_id": businessTypeId,
    "branch": branch,
    "company_id": companyId,
    "branch_id": branchId,
  };
}
