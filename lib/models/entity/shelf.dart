import 'dart:convert';

class Shelf {
  final int id;
  final int storageId;
  final String size;
  final int status;
  final int usage;
  Shelf({
    this.id,
    this.storageId,
    this.size,
    this.status,
    this.usage,
  });

  Shelf copyWith({
    int id,
    int storageId,
    String size,
    int status,
    int usage,
  }) {
    return Shelf(
      id: id ?? this.id,
      storageId: storageId ?? this.storageId,
      size: size ?? this.size,
      status: status ?? this.status,
      usage: usage ?? this.usage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storageId': storageId,
      'size': size,
      'status': status,
      'usage': usage,
    };
  }

  factory Shelf.fromMap(Map<String, dynamic> map) {
    return Shelf(
      id: map['id']?.toInt(),
      storageId: map['storageId']?.toInt(),
      size: map['size'],
      status: map['status']?.toInt(),
      usage: map['usage']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shelf.fromJson(String source) => Shelf.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shelf(id: $id, storageId: $storageId, size: $size, status: $status, usage: $usage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Shelf &&
        other.id == id &&
        other.storageId == storageId &&
        other.size == size &&
        other.status == status &&
        other.usage == usage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        storageId.hashCode ^
        size.hashCode ^
        status.hashCode ^
        usage.hashCode;
  }
}
