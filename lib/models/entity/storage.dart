import 'dart:convert';

enum StorageStatus { pending, reject, approved }

class Storage {
  final int id;
  final int ownerId;
  final String address;
  final int rating;
  final List<dynamic> picture;
  final String name;
  final String description;
  final int status;
  final String ownerName;
  final String ownerPhone;
  final double priceFrom;
  final double priceTo;
  String ownerAvatar;
  Storage(
      {this.id,
      this.address,
      this.description,
      this.name,
      this.ownerPhone,
      this.ownerId,
      this.ownerName,
      this.picture,
      this.priceFrom,
      this.priceTo,
      this.rating,
      this.ownerAvatar,
      this.status});

  Storage copyWith({
    int id,
    String ownerId,
    String address,
    int rating,
    String picture,
    String name,
    String description,
    String ownerPhone,
    String ownerAvatar,
    StorageStatus status,
    String ownerName,
    int priceFrom,
    int priceTo,
  }) {
    return Storage(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        ownerAvatar: ownerAvatar ?? this.ownerAvatar,
        address: address ?? this.address,
        rating: rating ?? this.rating,
        picture: picture ?? this.picture,
        name: name ?? this.name,
        description: description ?? this.description,
        status: status ?? this.status,
        ownerName: ownerName ?? this.ownerName,
        priceFrom: priceFrom ?? this.priceFrom,
        priceTo: priceTo ?? this.priceTo,
        ownerPhone: ownerPhone ?? this.ownerPhone);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'address': address,
      'rating': rating,
      'picture': picture,
      'name': name,
      'description': description,
      'status': status,
      'ownerName': ownerName,
      'priceFrom': priceFrom,
      'priceTo': priceTo,
      'ownerPhone': ownerPhone,
      "ownerAvatar": ownerAvatar
    };
  }

  factory Storage.fromMap(Map<String, dynamic> map) {
    return Storage(
      id: map['id']?.toInt(),
      ownerId: map['ownerId'].toInt(),
      address: map['address'],
      rating: map['rating']?.toInt(),
      picture: map['images'],
      name: map['name'],
      ownerPhone: map['ownerPhone'],
      description: map['description'],
      status: map['status']?.toInt(),
      ownerName: map['ownerName'],
      ownerAvatar: map['ownerAvatar'],
      priceFrom: map['priceFrom']?.toDouble(),
      priceTo: map['priceTo']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Storage.fromJson(String source) =>
      Storage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Storage.dart(id: $id, ownerId: $ownerId, address: $address, rating: $rating, picture: $picture, name: $name, description: $description, status: $status, ownerName: $ownerName, priceFrom: $priceFrom, priceTo: $priceTo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Storage &&
        other.id == id &&
        other.ownerId == ownerId &&
        other.address == address &&
        other.rating == rating &&
        other.picture == picture &&
        other.name == name &&
        other.ownerAvatar == ownerAvatar &&
        other.description == description &&
        other.status == status &&
        other.ownerName == ownerName &&
        other.ownerPhone == ownerPhone &&
        other.priceFrom == priceFrom &&
        other.priceTo == priceTo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ownerId.hashCode ^
        address.hashCode ^
        rating.hashCode ^
        picture.hashCode ^
        ownerPhone.hashCode ^
        name.hashCode ^
        description.hashCode ^
        ownerAvatar.hashCode ^
        status.hashCode ^
        ownerName.hashCode ^
        priceFrom.hashCode ^
        priceTo.hashCode;
  }
}
