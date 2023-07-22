// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CouponResponseModel extends Equatable {
  final int id;
  final String name;
  final String code;
  final String offerType;
  final String discount;
  final String maxQuantity;
  final String expiredDate;
  final String applyQty;
  final String status;
  final String createdAt;
  final String updatedAt;

  const CouponResponseModel({
    required this.id,
    required this.name,
    required this.code,
    required this.offerType,
    required this.discount,
    required this.maxQuantity,
    required this.expiredDate,
    required this.applyQty,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CouponResponseModel copyWith({
    int? id,
    String? name,
    String? code,
    String? offerType,
    String? discount,
    String? maxQuantity,
    String? expiredDate,
    String? applyQty,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return CouponResponseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      offerType: offerType ?? this.offerType,
      discount: discount ?? this.discount,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      expiredDate: expiredDate ?? this.expiredDate,
      applyQty: applyQty ?? this.applyQty,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'offer_type': offerType,
      'discount': discount,
      'max_quantity': maxQuantity,
      'expired_date': expiredDate,
      'apply_qty': applyQty,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CouponResponseModel.fromMap(Map<String, dynamic> map) {
    return CouponResponseModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      code: map['code'] ?? "",
      offerType: map['offer_type'] ?? "",
      discount: map['discount'] ?? "",
      maxQuantity: map['max_quantity'] ?? "",
      expiredDate: map['expired_date'] ?? "",
      applyQty: map['apply_qty'] ?? "",
      status: map['status'] ?? "",
      createdAt: map['created_at'] ?? "",
      updatedAt: map['updated_at'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponResponseModel.fromJson(String source) =>
      CouponResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      code,
      offerType,
      discount,
      maxQuantity,
      expiredDate,
      applyQty,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
