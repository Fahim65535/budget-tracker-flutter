import 'package:budget_tracker_app/screens/home.dart';
import 'package:budget_tracker_app/view_models/budget_view_model.dart';
import 'package:budget_tracker_app/services/local_storage_service.dart';
import 'package:budget_tracker_app/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorageService = LocalStorageService();
  await localStorageService.initializeHive();
  final sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPref: sharedPref,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPref;
  const MyApp({Key? key, required this.sharedPref}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(
            create: (_) => ThemeService(sharedPref)),
        ChangeNotifierProvider<BudgetViewModel>(
            create: (_) => BudgetViewModel()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final themeService = Provider.of<ThemeService>(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                      brightness: themeService.darkTheme
                          ? Brightness.dark
                          : Brightness.light,
                      seedColor: Colors.indigo)),
              home: const Home());
        },
      ),
    );
  }
}
