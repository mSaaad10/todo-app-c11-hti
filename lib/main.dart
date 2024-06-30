import 'package:daily_tasks_app/firebase_options.dart';
import 'package:daily_tasks_app/providers/authentication_provider.dart';
import 'package:daily_tasks_app/styles/my_theme.dart';
import 'package:daily_tasks_app/ui/auth/login/login_screen.dart';
import 'package:daily_tasks_app/ui/auth/register/register_screen.dart';
import 'package:daily_tasks_app/ui/home/home_screen.dart';
import 'package:daily_tasks_app/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: MyApp()));
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      locale: Locale('en'),
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
      routes: {
        RegisterScreen.routeName :(context) => RegisterScreen(),
        LoginScreen.routeName :(context) => LoginScreen(),
        HomeScreen.routeName:(context) => HomeScreen(),
        SplashScreen.routeName:(context) => SplashScreen(),

      },
      initialRoute: LoginScreen.routeName,
    );
  }

}
