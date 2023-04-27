part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

class ChangeMainAppColor extends AppSettingsEvent {
  final Color newMainColor;
  const ChangeMainAppColor(this.newMainColor);
}

class ChangeAdditionalAppColor extends AppSettingsEvent {
  final Color newAdditionalColor;
  const ChangeAdditionalAppColor(this.newAdditionalColor);
}

class ChangeMainAppColorDark extends AppSettingsEvent {
  final Color newMainColorDark;
  const ChangeMainAppColorDark(this.newMainColorDark);
}

class ChangeAdditionalAppColorDark extends AppSettingsEvent {
  final Color newAdditionalColorDark;
  const ChangeAdditionalAppColorDark(this.newAdditionalColorDark);
}

class ToggleDarkMode extends AppSettingsEvent {
  final bool darkModeValue;
  const ToggleDarkMode(this.darkModeValue);
}

class ToggleAnimationUse extends AppSettingsEvent {
  final bool animationUseValue;
  const ToggleAnimationUse(this.animationUseValue);
}
