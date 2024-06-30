// To parse this JSON data, do
//
//     final businessTypeResModel = businessTypeResModelFromJson(jsonString);

import 'dart:convert';

BusinessTypeResModel businessTypeResModelFromJson(String str) => BusinessTypeResModel.fromJson(json.decode(str));

String businessTypeResModelToJson(BusinessTypeResModel data) => json.encode(data.toJson());

class BusinessTypeResModel {
  final int status;
  final String msg;
  final String description;
  final List<BusinessType> businessTypes;

  BusinessTypeResModel({
    required this.status,
    required this.msg,
    required this.description,
    required this.businessTypes,
  });

  BusinessTypeResModel copyWith({
    int? status,
    String? msg,
    String? description,
    List<BusinessType>? businessTypes,
  }) =>
      BusinessTypeResModel(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        description: description ?? this.description,
        businessTypes: businessTypes ?? this.businessTypes,
      );

  factory BusinessTypeResModel.fromJson(Map<String, dynamic> json) => BusinessTypeResModel(
    status: json["status"],
    msg: json["msg"],
    description: json["description"],
    businessTypes: List<BusinessType>.from(json["business_types"].map((x) => BusinessType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "description": description,
    "business_types": List<dynamic>.from(businessTypes.map((x) => x.toJson())),
  };
}

class BusinessType {
  final int id;
  final String name;
  final String slug;

  BusinessType({
    required this.id,
    required this.name,
    required this.slug,
  });

  BusinessType copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      BusinessType(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}
