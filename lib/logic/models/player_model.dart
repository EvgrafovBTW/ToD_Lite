// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class PlayerModel {
  final int id;
  final String gender;
  final String name;
  final Color playerColor;
  PlayerModel({
    required this.id,
    required this.gender,
    required this.name,
    required this.playerColor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'gender': gender,
      'name': name,
      'playerColor': playerColor.value,
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      id: map['id'] as int,
      gender: map['gender'] as String,
      name: map['name'] as String,
      playerColor: Color(map['playerColor'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerModel.fromJson(String source) =>
      PlayerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PlayerModel copyWith({
    int? id,
    String? gender,
    String? name,
    Color? playerColor,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      playerColor: playerColor ?? this.playerColor,
    );
  }
}
