import 'dart:convert';

import 'package:flutter/cupertino.dart';

enum StorageStatus { pending, reject, approved }

class Storage with ChangeNotifier {
  int id;
  int ownerId;
  String address;
  int rating;
  int numberOfRatings;
  List<dynamic> picture;
  String name;
  String description;
  int status;
  String ownerName;
  String ownerPhone;
  double priceFrom;
  double priceTo;
  String rejectedReason;
  String ownerAvatar;
  int remainingBoxes;
  Storage(
      {this.id,
      this.rejectedReason,
      this.address,
      this.description,
      this.remainingBoxes,
      this.name,
      this.numberOfRatings,
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
    String rejectedReason,
    int numberOfRatings,
    String ownerAvatar,
    StorageStatus status,
    String ownerName,
    int priceFrom,
    int priceTo,
    int remainingBoxes,
  }) {
    return Storage(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        ownerAvatar: ownerAvatar ?? this.ownerAvatar,
        address: address ?? this.address,
        rejectedReason: rejectedReason ?? this.rejectedReason,
        rating: rating ?? this.rating,
        picture: picture ?? this.picture,
        remainingBoxes: remainingBoxes ?? this.remainingBoxes,
        name: name ?? this.name,
        numberOfRatings: numberOfRatings ?? this.numberOfRatings,
        description: description ?? this.description,
        status: status ?? this.status,
        ownerName: ownerName ?? this.ownerName,
        priceFrom: priceFrom ?? this.priceFrom,
        priceTo: priceTo ?? this.priceTo,
        ownerPhone: ownerPhone ?? this.ownerPhone);
  }

  Storage.empty() {
    this.address = '';
    this.description = '';
    this.id = -1;
    this.name = '';
    this.numberOfRatings = -1;
    this.ownerAvatar = '';
    this.ownerId = -1;
    this.ownerName = '';
    this.rejectedReason = '';
    this.ownerPhone = '';
    this.remainingBoxes = -1;
    this.picture = [];
    this.priceFrom = -1;
    this.priceTo = -1;
    this.status = -1;
  }

  void setStorage(Storage storage) {
    this.id = storage.id;
    this.rejectedReason = storage.rejectedReason;
    this.address = storage.address;
    this.description = storage.description;
    this.name = storage.name;
    this.numberOfRatings = storage.numberOfRatings;
    this.ownerPhone = storage.ownerPhone;
    this.ownerId = storage.ownerId;
    this.ownerName = storage.ownerName;
    this.picture = storage.picture;
    this.priceFrom = storage.priceFrom;
    this.priceTo = storage.priceTo;
    this.remainingBoxes = storage.remainingBoxes;
    this.rating = storage.rating;
    this.ownerAvatar = storage.ownerAvatar;
    this.status = storage.status;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'address': address,
      'rating': rating,
      'picture': picture,
      'name': name,
      'remainingBoxes': remainingBoxes,
      'description': description,
      'status': status,
      'rejectedReason': rejectedReason,
      'ownerName': ownerName,
      'priceFrom': priceFrom,
      'numberOfRatings': numberOfRatings,
      'priceTo': priceTo,
      'ownerPhone': ownerPhone,
      "ownerAvatar": ownerAvatar
    };
  }

  factory Storage.fromMap(Map<String, dynamic> map) {
    return Storage(
      id: map['id']?.toInt(),
      ownerId: map['ownerId']?.toInt(),
      address: map['address'],
      rating: map['rating']?.toInt(),
      rejectedReason: map['rejectedReason'],
      picture: map['images'],
      name: map['name'],
      numberOfRatings: map['numberOfRatings']?.toInt(),
      ownerPhone: map['ownerPhone'],
      description: map['description'],
      remainingBoxes: map['remainingBoxes']?.toInt(),
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
        other.numberOfRatings == numberOfRatings &&
        other.ownerAvatar == ownerAvatar &&
        other.description == description &&
        other.numberOfRatings == numberOfRatings &&
        other.status == status &&
        other.remainingBoxes == remainingBoxes &&
        other.rejectedReason == rejectedReason &&
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
        rejectedReason.hashCode ^
        picture.hashCode ^
        remainingBoxes.hashCode ^
        numberOfRatings.hashCode ^
        ownerPhone.hashCode ^
        name.hashCode ^
        description.hashCode ^
        numberOfRatings.hashCode ^
        ownerAvatar.hashCode ^
        status.hashCode ^
        ownerName.hashCode ^
        priceFrom.hashCode ^
        priceTo.hashCode;
  }
}
