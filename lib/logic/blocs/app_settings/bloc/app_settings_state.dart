// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'app_settings_bloc.dart';

class AppSettingsState extends Equatable {
  final Color primaryColor;
  final Color secondary;
  final Color primaryColorDark;
  final Color secondaryDark;
  final bool isDarkMode;
  final bool removeAnimations;
  const AppSettingsState({
    this.primaryColor = const Color(0xff6200ee),
    this.secondary = const Color(0xff03dac6),
    this.primaryColorDark = const Color(0xffbb86fc),
    this.secondaryDark = const Color(0xff03dac6),
    this.isDarkMode = false,
    this.removeAnimations = false,
  });

  @override
  List<Object> get props => [
        primaryColor,
        primaryColorDark,
        secondary,
        secondaryDark,
        isDarkMode,
        removeAnimations,
      ];

  AppSettingsState copyWith({
    Color? primaryColor,
    Color? secondary,
    Color? primaryColorDark,
    Color? secondaryDark,
    bool? isDarkMode,
    bool? removeAnimations,
  }) {
    return AppSettingsState(
      primaryColor: primaryColor ?? this.primaryColor,
      secondary: secondary ?? this.secondary,
      primaryColorDark: primaryColorDark ?? this.primaryColorDark,
      secondaryDark: secondaryDark ?? this.secondaryDark,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      removeAnimations: removeAnimations ?? this.removeAnimations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'primaryColor': primaryColor.value,
      'secondary': secondary.value,
      'primaryColorDark': primaryColorDark.value,
      'secondaryDark': secondaryDark.value,
      'isDarkMode': isDarkMode,
      'removeAnimations': removeAnimations,
    };
  }

  factory AppSettingsState.fromMap(Map<String, dynamic> map) {
    return AppSettingsState(
      primaryColor: Color(map['primaryColor'] as int),
      secondary: Color(map['secondary'] as int),
      primaryColorDark: Color(map['primaryColorDark'] as int),
      secondaryDark: Color(map['secondaryDark'] as int),
      isDarkMode: map['isDarkMode'] as bool,
      removeAnimations: map['removeAnimations'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettingsState.fromJson(String source) =>
      AppSettingsState.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AppSettingsInitial extends AppSettingsState {}
