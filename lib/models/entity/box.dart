import 'dart:convert';

import 'package:flutter/foundation.dart';

class Box {
  final int id;
  final int shelfId;
  final String type;
  final String size;
  final double price;
  final int status;

  Box({
    this.id,
    this.shelfId,
    this.type,
    this.size,
    this.price,
    this.status,
  });

  Box copyWith({
    int id,
    int shelfId,
    String type,
    String size,
    double price,
    int status,
  }) {
    return Box(
      id: id ?? this.id,
      shelfId: shelfId ?? this.shelfId,
      type: type ?? this.type,
      size: size ?? this.size,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toInt(),
      'shelfId': shelfId.toInt(),
      'type': type,
      'size': size,
      'price': price.toDouble(),
      'status': status,
    };
  }

  factory Box.fromMap(Map<String, dynamic> map) {
    return Box(
      id: map['id']?.toInt(),
      shelfId: map['shelfId']?.toInt(),
      type: map['type'],
      size: map['size'],
      price: map['price']?.toDouble(),
      status: map['status']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Box.fromJson(String source) => Box.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Box &&
        other.id == id &&
        other.shelfId == shelfId &&
        other.type == type &&
        other.size == size &&
        other.price == price &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shelfId.hashCode ^
        type.hashCode ^
        size.hashCode ^
        price.hashCode ^
        status.hashCode;
  }
}
