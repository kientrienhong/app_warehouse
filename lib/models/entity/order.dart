import 'dart:convert';

class Order {
  final int id;
  final String name;
  final String address;
  final double total;
  final int month;
  final int smallBoxQuantity;
  final double smallBoxPrice;
  final int bigBoxQuantity;
  final double bigBoxPrice;
  final String ownerPhone;
  final String ownerName;
  final String ownerAvatar;
  final int status;
  Order({
    this.id,
    this.name,
    this.address,
    this.total,
    this.month,
    this.smallBoxQuantity,
    this.smallBoxPrice,
    this.bigBoxQuantity,
    this.bigBoxPrice,
    this.ownerPhone,
    this.ownerName,
    this.ownerAvatar,
    this.status,
  });

  Order copyWith({
    int id,
    String name,
    String address,
    double total,
    int month,
    int smallBoxQuantity,
    double smallBoxPrice,
    int bigBoxQuantity,
    double bigBoxPrice,
    String ownerPhone,
    String ownerName,
    String ownerAvatar,
    int status,
  }) {
    return Order(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      total: total ?? this.total,
      month: month ?? this.month,
      smallBoxQuantity: smallBoxQuantity ?? this.smallBoxQuantity,
      smallBoxPrice: smallBoxPrice ?? this.smallBoxPrice,
      bigBoxQuantity: bigBoxQuantity ?? this.bigBoxQuantity,
      bigBoxPrice: bigBoxPrice ?? this.bigBoxPrice,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      ownerName: ownerName ?? this.ownerName,
      ownerAvatar: ownerAvatar ?? this.ownerAvatar,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'total': total,
      'month': month,
      'smallBoxQuantity': smallBoxQuantity,
      'smallBoxPrice': smallBoxPrice,
      'bigBoxQuantity': bigBoxQuantity,
      'bigBoxPrice': bigBoxPrice,
      'ownerPhone': ownerPhone,
      'ownerName': ownerName,
      'ownerAvatar': ownerAvatar,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id']?.toInt(),
      name: map['name'],
      address: map['address'],
      total: map['total']?.toInt(),
      month: map['month']?.toInt(),
      smallBoxQuantity: map['smallBoxQuantity']?.toInt(),
      smallBoxPrice: map['smallBoxPrice']?.toDouble(),
      bigBoxQuantity: map['bigBoxQuantity']?.toInt(),
      bigBoxPrice: map['bigBoxPrice']?.toDouble(),
      ownerPhone: map['ownerPhone'],
      ownerName: map['ownerName'],
      ownerAvatar: map['ownerAvatar'],
      status: map['status']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, name: $name, address: $address, total: $total, month: $month, smallBoxQuantity: $smallBoxQuantity, smallBoxPrice: $smallBoxPrice, bigBoxQuantity: $bigBoxQuantity, bigBoxPrice: $bigBoxPrice, ownerPhone: $ownerPhone, ownerName: $ownerName, ownerAvatar: $ownerAvatar, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.total == total &&
        other.month == month &&
        other.smallBoxQuantity == smallBoxQuantity &&
        other.smallBoxPrice == smallBoxPrice &&
        other.bigBoxQuantity == bigBoxQuantity &&
        other.bigBoxPrice == bigBoxPrice &&
        other.ownerPhone == ownerPhone &&
        other.ownerName == ownerName &&
        other.ownerAvatar == ownerAvatar &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        total.hashCode ^
        month.hashCode ^
        smallBoxQuantity.hashCode ^
        smallBoxPrice.hashCode ^
        bigBoxQuantity.hashCode ^
        bigBoxPrice.hashCode ^
        ownerPhone.hashCode ^
        ownerName.hashCode ^
        ownerAvatar.hashCode ^
        status.hashCode;
  }
}
