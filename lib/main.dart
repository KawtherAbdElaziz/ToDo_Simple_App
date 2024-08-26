import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_simple_app/core/page_route_names.dart';
import 'package:todo_simple_app/core/route_generator.dart';
import 'package:todo_simple_app/core/services/loading_service.dart';
import 'package:todo_simple_app/core/settings_provider.dart';
import 'package:todo_simple_app/core/theme/application_theme.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => SettingsProvider(), child: const MyApp()));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.currentLangauge),
      theme: ApplicationThemeManager.lightTheme,
      themeMode: provider.currentThemeMode,
      darkTheme: ApplicationThemeManager.darkTheme,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      initialRoute: PageRouteNames.initial,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(
          builder: BotToastInit()
      ),
    );
  }
}
