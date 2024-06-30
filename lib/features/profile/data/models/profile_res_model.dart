// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileResponseModel profileResponseModelFromJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) => json.encode(data.toJson());

class ProfileResponseModel {
  final int status;
  final String msg;
  final String description;
  final ResponseUser responseUser;

  ProfileResponseModel({
    required this.status,
    required this.msg,
    required this.description,
    required this.responseUser,
  });

  ProfileResponseModel copyWith({
    int? status,
    String? msg,
    String? description,
    ResponseUser? responseUser,
  }) =>
      ProfileResponseModel(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        description: description ?? this.description,
        responseUser: responseUser ?? this.responseUser,
      );

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
    status: json["status"],
    msg: json["msg"],
    description: json["description"],
    responseUser: ResponseUser.fromJson(json["response_user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "description": description,
    "response_user": responseUser.toJson(),
  };
}

class ResponseUser {
  final int id;
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

  ResponseUser({
    required this.id,
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

  ResponseUser copyWith({
    int? id,
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
      ResponseUser(
        id: id ?? this.id,
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

  factory ResponseUser.fromJson(Map<String, dynamic> json) => ResponseUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"]??"",
    imageFullPath: json["image_full_path"]??"",
    businessName: json["business_name"],
    businessType: json["business_type"],
    businessTypeId: json["business_type_id"],
    branch: json["branch"],
    companyId: json["company_id"],
    branchId: json["branch_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
