// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

abstract class GameModeModel {
  int id;
  String title;
  String? description;
  Widget icon;
  GameModeModel({
    required this.id,
    required this.title,
    this.description,
    required this.icon,
  });
}

class FirstGameModel extends GameModeModel {
  FirstGameModel({
    super.id = 0,
    super.title = 'За первую встречу',
    super.description = 'Подходит для первого знакомства',
    super.icon = const Icon(
      Icons.person_outline,
    ),
  });
}

class SecondGameModel extends GameModeModel {
  SecondGameModel({
    super.id = 1,
    super.title = 'Для друзей',
    super.description = 'Подходит для уже знакомой компании',
    super.icon = const Icon(
      Icons.person_outline,
    ),
  });
}

class ThirdGameModel extends GameModeModel {
  ThirdGameModel({
    super.id = 2,
    super.title = 'Будет жарко',
    super.description = 'Для любителей пикантных посиделок',
    super.icon = const Icon(
      Icons.person_outline,
    ),
  });
}

class FourthGameModel extends GameModeModel {
  FourthGameModel({
    super.id = 3,
    super.title = 'Без тормозов',
    super.description = 'Стыд это вообще кто такой?',
    super.icon = const Icon(
      Icons.person_outline,
    ),
  });
}
