import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:truth_or_dare_lite/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:truth_or_dare_lite/logic/blocs/game_bloc/bloc/game_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:truth_or_dare_lite/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (details) {
    return Material(
      child: Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                details.exception.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  };

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GameBloc(),
        ),
        BlocProvider(
          create: (context) => AppSettingsBloc(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return OverlaySupport.global(
          child: PlatformApp(
            debugShowCheckedModeBanner: false,
            material: (context, platform) => MaterialAppData(
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: state.isDarkMode
                    ? ColorScheme.dark(
                        primary: state.primaryColorDark,
                        secondary: state.secondaryDark,
                      )
                    : ColorScheme.light(
                        primary: state.primaryColor,
                        secondary: state.secondary,
                      ),
              ),
            ),
            cupertino: (context, platform) => CupertinoAppData(),
            home: const MainScreen(),
          ),
        );
      },
    );
  }
}
