import 'dart:convert';

class Order {
  final int id;
  final int idStorage;
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
  final String expiredDate;
  final int status;
  final String comment;
  final double rating;
  Order({
    this.id,
    this.expiredDate,
    this.name,
    this.idStorage,
    this.address,
    this.rating,
    this.total,
    this.month,
    this.comment,
    this.smallBoxQuantity,
    this.smallBoxPrice,
    this.bigBoxQuantity,
    this.bigBoxPrice,
    this.ownerPhone,
    this.ownerName,
    this.ownerAvatar,
    this.status,
  });

  Order copyWith(
      {int id,
      String name,
      String address,
      double total,
      int idStorage,
      int month,
      String expiredDate,
      int smallBoxQuantity,
      String comment,
      double smallBoxPrice,
      int bigBoxQuantity,
      double bigBoxPrice,
      String ownerPhone,
      String ownerName,
      String ownerAvatar,
      int status,
      double rating}) {
    return Order(
      expiredDate: expiredDate ?? this.expiredDate,
      rating: rating ?? this.rating,
      id: id ?? this.id,
      comment: comment ?? this.comment,
      name: name ?? this.name,
      address: address ?? this.address,
      total: total ?? this.total,
      month: month ?? this.month,
      idStorage: idStorage ?? this.idStorage,
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
      'expiredDate': expiredDate,
      'storageId': idStorage,
      'address': address,
      'total': total,
      'comment': comment,
      'months': month,
      'rating': rating,
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
        total: map['total']?.toDouble(),
        month: map['months']?.toInt(),
        idStorage: map['storageId'].toInt(),
        smallBoxQuantity: map['smallBoxQuantity']?.toInt(),
        smallBoxPrice: map['smallBoxPrice']?.toDouble(),
        bigBoxQuantity: map['bigBoxQuantity']?.toInt(),
        bigBoxPrice: map['bigBoxPrice']?.toDouble(),
        ownerPhone: map['ownerPhone'],
        rating: map['rating'] == null ? null : map['rating'].toDouble(),
        expiredDate: map['expiredDate'],
        ownerName: map['ownerName'],
        ownerAvatar: map['ownerAvatar'],
        status: map['status']?.toInt(),
        comment: map['comment']);
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
        other.comment == comment &&
        other.expiredDate == expiredDate &&
        other.rating == rating &&
        other.total == total &&
        other.month == month &&
        other.idStorage == idStorage &&
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
        idStorage.hashCode ^
        total.hashCode ^
        rating.hashCode ^
        comment.hashCode ^
        month.hashCode ^
        expiredDate.hashCode ^
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
