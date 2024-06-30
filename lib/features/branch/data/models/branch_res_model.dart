// To parse this JSON data, do
//
//     final branchResponseModel = branchResponseModelFromJson(jsonString);

import 'dart:convert';

BranchResponseModel branchResponseModelFromJson(String str) => BranchResponseModel.fromJson(json.decode(str));

String branchResponseModelToJson(BranchResponseModel data) => json.encode(data.toJson());

class BranchResponseModel {
  final int status;
  final String msg;
  final String description;
  final Branches branches;

  BranchResponseModel({
    required this.status,
    required this.msg,
    required this.description,
    required this.branches,
  });

  BranchResponseModel copyWith({
    int? status,
    String? msg,
    String? description,
    Branches? branches,
  }) =>
      BranchResponseModel(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        description: description ?? this.description,
        branches: branches ?? this.branches,
      );

  factory BranchResponseModel.fromJson(Map<String, dynamic> json) => BranchResponseModel(
    status: json["status"],
    msg: json["msg"],
    description: json["description"],
    branches: Branches.fromJson(json["branches"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "description": description,
    "branches": branches.toJson(),
  };
}

class Branches {
  final int total;
  final List<Branch> branches;

  Branches({
    required this.total,
    required this.branches,
  });

  Branches copyWith({
    int? total,
    List<Branch>? branches,
  }) =>
      Branches(
        total: total ?? this.total,
        branches: branches ?? this.branches,
      );

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
    total: json["total"],
    branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
  };
}

class Branch {
  final int id;
  final String name;

  Branch({
    required this.id,
    required this.name,
  });

  Branch copyWith({
    int? id,
    String? name,
  }) =>
      Branch(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
