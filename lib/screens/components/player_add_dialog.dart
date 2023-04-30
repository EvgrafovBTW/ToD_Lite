import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:truth_or_dare_lite/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:truth_or_dare_lite/logic/blocs/game_bloc/bloc/game_bloc.dart';
import 'package:truth_or_dare_lite/logic/models/player_model.dart';
import 'package:truth_or_dare_lite/screens/settings_screen.dart';

class PlayerAddDialog extends StatefulWidget {
  final PlayerModel? player;
  const PlayerAddDialog({
    this.player,
    super.key,
  });

  @override
  State<PlayerAddDialog> createState() => _PlayerAddDialogState();
}

class _PlayerAddDialogState extends State<PlayerAddDialog> {
  late TextEditingController controller;
  late ValueNotifier genderValue;
  late ValueNotifier color;
  bool validatePlayerData() {
    if (controller.value.text.isEmpty) {
      showSimpleNotification(const Text('Заполните имя игрока'));
      return false;
    }
    if (genderValue.value == 'N') {
      showSimpleNotification(const Text('Выберите пол игрока'));
      return false;
    }
    return true;
  }

  @override
  void initState() {
    if (widget.player != null) {
      controller = TextEditingController(text: widget.player!.name);
      genderValue = ValueNotifier<String>(widget.player!.gender);
      color = ValueNotifier<Color>(widget.player!.playerColor);
    } else {
      controller = TextEditingController();
      genderValue = ValueNotifier<String>('N');
      color = ValueNotifier<Color>(
        Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    genderValue.dispose();
    color.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox.fromSize(
        size: MediaQuery.of(context).size / 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DialogSectionName(widget.player != null
                    ? 'Редактировать игрока'
                    : 'Новый игрок'),
                TextField(
                  controller: controller,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Имя игрока',
                  ),
                ),
                const DialogSectionName('Пол'),
                DialogGenderCard('Мужской', genderValue: genderValue),
                DialogGenderCard('Женский', genderValue: genderValue),
                const DialogSectionName('Цвет игрока'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: GestureDetector(
                    onTap: () => showPlatformModalSheet(
                      context: context,
                      builder: (context) => Column(
                        children: [
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 40),
                              children: [
                                for (Color c in Colors.primaries)
                                  GestureDetector(
                                    onTap: () {
                                      color.value = c;
                                      Navigator.pop(context);
                                    },
                                    child: SettingsColorPane(
                                      color: c,
                                      isDarkMode:
                                          BlocProvider.of<AppSettingsBloc>(
                                                  context)
                                              .state
                                              .isDarkMode,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: color,
                      builder: (context, value, child) {
                        return SettingsColorPane(
                          side: MediaQuery.of(context).size.height * 0.05,
                          color: color.value,
                          isDarkMode: BlocProvider.of<AppSettingsBloc>(context)
                              .state
                              .isDarkMode,
                        );
                      },
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Отменить'),
                      ),
                      const VerticalDivider(thickness: 0.2),
                      TextButton(
                        onPressed: () {
                          if (widget.player == null) {
                            if (validatePlayerData()) {
                              BlocProvider.of<GameBloc>(context).add(
                                AddPlayer(
                                  PlayerModel(
                                    id: BlocProvider.of<GameBloc>(context)
                                        .state
                                        .players
                                        .length,
                                    gender: genderValue.value,
                                    name: controller.value.text,
                                    playerColor: color.value,
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          } else {
                            BlocProvider.of<GameBloc>(context).add(
                              EditPlayer(
                                PlayerModel(
                                  id: widget.player!.id,
                                  gender: genderValue.value,
                                  name: controller.value.text,
                                  playerColor: color.value,
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                            widget.player != null ? 'Применить' : 'Добавить'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DialogGenderCard extends StatelessWidget {
  final String gender;

  final ValueNotifier genderValue;
  const DialogGenderCard(
    this.gender, {
    required this.genderValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: genderValue,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () => genderValue.value = gender,
          child: Card(
            elevation: genderValue.value == gender ? 1 : 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(gender),
                  Visibility(
                    visible: genderValue.value == gender,
                    child: const Icon(Icons.check),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DialogSectionName extends StatelessWidget {
  final String name;
  const DialogSectionName(
    this.name, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(name),
    );
  }
}
