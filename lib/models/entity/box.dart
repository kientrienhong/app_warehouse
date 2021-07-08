import 'dart:convert';

class Box {
  final int id;
  final int shelfId;
  final int type;
  final String size;
  final double price;
  final int status;
  final String position;
  Box({
    this.id,
    this.position,
    this.shelfId,
    this.type,
    this.size,
    this.price,
    this.status,
  });

  Box copyWith({
    int id,
    int shelfId,
    int type,
    String size,
    double price,
    String position,
    int status,
  }) {
    return Box(
      id: id ?? this.id,
      position: position ?? this.position,
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
      'type': type.toInt(),
      'size': size,
      'price': price.toDouble(),
      'status': status,
      'position': position
    };
  }

  factory Box.fromMap(Map<String, dynamic> map) {
    return Box(
        id: map['id']?.toInt(),
        shelfId: map['shelfId']?.toInt(),
        type: map['type']?.toInt(),
        size: map['size'],
        price: map['price']?.toDouble(),
        status: map['status']?.toInt(),
        position: map['position']);
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
        other.position == position &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shelfId.hashCode ^
        type.hashCode ^
        position.hashCode ^
        size.hashCode ^
        price.hashCode ^
        status.hashCode;
  }
}
