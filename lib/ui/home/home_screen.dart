import 'package:daily_tasks_app/ui/home/settings_tab/Settings_tab.dart';
import 'package:daily_tasks_app/ui/home/task_bottom_sheet.dart';
import 'package:daily_tasks_app/ui/home/tasks_list_tab/tasks_list_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  String appBarTitle = 'Tasks list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        onPressed: () {
          addTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            if (index == 0) {
              appBarTitle = 'Tasks Tab';
            } else {
              appBarTitle = 'Setting Tab';
            }
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list, ), label: AppLocalizations.of(context)!.tasks_list_tab),
            BottomNavigationBarItem(icon: Icon(Icons.settings, ), label: AppLocalizations.of(context)!.settings_tab)
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
  List<Widget> tabs= [TasksListTab(), SettingsTab()];

  void addTaskBottomSheet() {
    showModalBottomSheet(context: context, builder: (context) => AddTaskBottomSheet(),);
  }
}
