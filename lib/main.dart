import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loop_lab/Widgets/app_colors.dart';
import 'package:loop_lab/firebase_options.dart';
import 'package:loop_lab/splash_screen.dart';
import 'package:loop_lab/widgets/navigation_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryBlue,
        hintColor: AppColors.primaryPurple,
        scaffoldBackgroundColor: AppColors.lightBackground,
        cardColor: AppColors.lightBackground,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
          bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightBackground,
          foregroundColor: AppColors.lightTextPrimary,
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryBlue,
        hintColor: AppColors.primaryPurple,
        scaffoldBackgroundColor: AppColors.darkBackground,
        cardColor: AppColors.darkCardBackground,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
          bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkCardBackground,
          foregroundColor: AppColors.darkTextPrimary,
        ),
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'LoopLab',
        theme: theme,
        darkTheme: darkTheme,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
