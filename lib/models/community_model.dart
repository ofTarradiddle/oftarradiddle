import 'package:flutter/foundation.dart';

class Community {
  final String id;
  final String name;
  final List<String> fieldNames;

  final String banner;
  final String avatar;
  final List<String> members;
  final List<String> mods;
  //fieldNames
  Community(
      {required this.fieldNames,
      required this.id,
      required this.name,
      required this.banner,
      required this.avatar,
      required this.members,
      required this.mods});

  Community copyWith({
    String? id,
    String? name,
    List<String>? fieldNames,
    String? banner,
    String? avatar,
    List<String>? members,
    List<String>? mods,
  }) {
    return Community(
      id: id ?? this.id,
      name: name ?? this.name,
      fieldNames: fieldNames ?? this.fieldNames,
      banner: banner ?? this.banner,
      avatar: avatar ?? this.avatar,
      members: members ?? this.members,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'fieldNames': fieldNames,
      'banner': banner,
      'avatar': avatar,
      'members': members,
      'mods': mods,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      fieldNames: List<String>.from(map['fieldNames']),
      banner: map['banner'] ?? '',
      avatar: map['avatar'] ?? '',
      members: List<String>.from(map['members']),
      mods: List<String>.from(map['mods']),
    );
  }

  @override
  String toString() {
    return 'Community(id: $id, name: $name, fieldNames: $fieldNames,banner: $banner, avatar: $avatar, members: $members, mods: $mods)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Community &&
        other.id == id &&
        other.name == name &&
        listEquals(other.fieldNames, fieldNames) &&
        other.banner == banner &&
        other.avatar == avatar &&
        listEquals(other.members, members) &&
        listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        fieldNames.hashCode ^
        banner.hashCode ^
        avatar.hashCode ^
        members.hashCode ^
        mods.hashCode;
  }
}
