// To parse this JSON data, do
//
//     final signUpResponseModel = signUpResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignUpResponseModel signUpResponseModelFromJson(String str) => SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) => json.encode(data.toJson());

class SignUpResponseModel {
  final int id;
  final String apiToken;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String imageFullPath;
  final String businessName;
  final String businessType;
  final int businessTypeId;
  final String branch;
  final int companyId;
  final int branchId;

  SignUpResponseModel({
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

  SignUpResponseModel copyWith({
    int? id,
    String? apiToken,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? imageFullPath,
    String? businessName,
    String? businessType,
    int? businessTypeId,
    String? branch,
    int? companyId,
    int? branchId,
  }) =>
      SignUpResponseModel(
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

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
    id: json["id"],
    apiToken: json["api_token"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"]??'',
    imageFullPath: json["image_full_path"]??'',
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
