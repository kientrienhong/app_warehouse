import 'dart:convert';

class OrderCustomer {
  final int id;
  final String name;
  final String address;
  final int total;
  final int months;
  final int smallBoxQuantity;
  final int smallBoxPrice;
  final int bigBoxQuantity;
  final int bigBoxPrice;
  final String customerPhone;
  final String customerName;
  final String customerAvatar;
  final double rating;
  final int storageId;
  final int status;
  final String expiredDate;
  final List<dynamic> boxUsed;
  OrderCustomer({
    this.id,
    this.expiredDate,
    this.name,
    this.address,
    this.total,
    this.months,
    this.boxUsed,
    this.smallBoxQuantity,
    this.smallBoxPrice,
    this.bigBoxQuantity,
    this.bigBoxPrice,
    this.customerPhone,
    this.customerName,
    this.customerAvatar,
    this.rating,
    this.storageId,
    this.status,
  });

  OrderCustomer copyWith({
    int id,
    String name,
    String address,
    int total,
    int months,
    String expiredDate,
    int smallBoxQuantity,
    int smallBoxPrice,
    int bigBoxQuantity,
    List<dynamic> boxUsed,
    int bigBoxPrice,
    String customerPhone,
    String customerName,
    String customerAvatar,
    double rating,
    int storageId,
    int status,
  }) {
    return OrderCustomer(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        total: total ?? this.total,
        months: months ?? this.months,
        smallBoxQuantity: smallBoxQuantity ?? this.smallBoxQuantity,
        smallBoxPrice: smallBoxPrice ?? this.smallBoxPrice,
        bigBoxQuantity: bigBoxQuantity ?? this.bigBoxQuantity,
        bigBoxPrice: bigBoxPrice ?? this.bigBoxPrice,
        customerPhone: customerPhone ?? this.customerPhone,
        boxUsed: boxUsed ?? this.boxUsed,
        customerName: customerName ?? this.customerName,
        customerAvatar: customerAvatar ?? this.customerAvatar,
        rating: rating ?? this.rating,
        storageId: storageId ?? this.storageId,
        status: status ?? this.status,
        expiredDate: expiredDate ?? this.expiredDate);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'total': total,
      'months': months,
      'smallBoxQuantity': smallBoxQuantity,
      'smallBoxPrice': smallBoxPrice,
      'expiredDate': expiredDate,
      'bigBoxQuantity': bigBoxQuantity,
      'bigBoxPrice': bigBoxPrice,
      'customerPhone': customerPhone,
      'customerName': customerName,
      'customerAvatar': customerAvatar,
      'rating': rating.toDouble(),
      'boxUsed': boxUsed,
      'storageId': storageId,
      'status': status,
    };
  }

  factory OrderCustomer.fromMap(Map<String, dynamic> map) {
    return OrderCustomer(
      id: map['id']?.toInt(),
      name: map['name'],
      address: map['address'],
      total: map['total']?.toInt(),
      months: map['months']?.toInt(),
      expiredDate: map['expiredDate'],
      smallBoxQuantity: map['smallBoxQuantity']?.toInt(),
      smallBoxPrice: map['smallBoxPrice']?.toInt(),
      bigBoxQuantity: map['bigBoxQuantity']?.toInt(),
      bigBoxPrice: map['bigBoxPrice']?.toInt(),
      customerPhone: map['customerPhone'],
      customerName: map['customerName'],
      boxUsed: map['boxUsed'],
      customerAvatar: map['customerAvatar'],
      rating: map['rating']?.toDouble(),
      storageId: map['storageId']?.toInt(),
      status: map['status']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCustomer.fromJson(String source) =>
      OrderCustomer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderCustomer(id: $id, name: $name, address: $address, total: $total, months: $months, smallBoxQuantity: $smallBoxQuantity, smallBoxPrice: $smallBoxPrice, bigBoxQuantity: $bigBoxQuantity, bigBoxPrice: $bigBoxPrice, customerPhone: $customerPhone, customerName: $customerName, customerAvatar: $customerAvatar, rating: $rating, storageId: $storageId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderCustomer &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.total == total &&
        other.months == months &&
        other.smallBoxQuantity == smallBoxQuantity &&
        other.smallBoxPrice == smallBoxPrice &&
        other.bigBoxQuantity == bigBoxQuantity &&
        other.bigBoxPrice == bigBoxPrice &&
        other.customerPhone == customerPhone &&
        other.customerName == customerName &&
        other.boxUsed == boxUsed &&
        other.customerAvatar == customerAvatar &&
        other.rating == rating &&
        other.storageId == storageId &&
        other.status == status &&
        other.expiredDate == expiredDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        total.hashCode ^
        months.hashCode ^
        smallBoxQuantity.hashCode ^
        boxUsed.hashCode ^
        smallBoxPrice.hashCode ^
        bigBoxQuantity.hashCode ^
        bigBoxPrice.hashCode ^
        customerPhone.hashCode ^
        expiredDate.hashCode ^
        customerName.hashCode ^
        customerAvatar.hashCode ^
        rating.hashCode ^
        storageId.hashCode ^
        status.hashCode;
  }
}
