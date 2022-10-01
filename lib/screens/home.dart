import 'package:budget_tracker_app/pages/home_page.dart';
import 'package:budget_tracker_app/pages/profile_page.dart';
import 'package:budget_tracker_app/view_models/budget_view_model.dart';
import 'package:budget_tracker_app/services/theme_service.dart';
import 'package:budget_tracker_app/widgets/budget_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> bottomnavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Budget Tracker"),
        ),
        leading: IconButton(
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },
          icon: Icon(themeService.darkTheme ? Icons.sunny : Icons.dark_mode),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return BudgetDialog(
                    budgetToAdd: (value) {
                      //provider
                      final budgetService = Provider.of<BudgetViewModel>(
                        context,
                        listen: false,
                      );
                      budgetService.budget = value;
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.attach_money),
          ),
        ],
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: bottomnavItems,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
