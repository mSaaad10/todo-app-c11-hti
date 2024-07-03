import 'package:daily_tasks_app/database_manager/tasks_dao.dart';
import 'package:daily_tasks_app/providers/authentication_provider.dart';
import 'package:daily_tasks_app/ui/components/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:provider/provider.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  var selectedData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(context);

    return Column(
      children: [
        TimelineCalendar(
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.black26,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
              compactMode: true,
              weekDaySelectedColor: const Color(0xff3AC3E2),
              disableDaysBeforeNow: true),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.FULL,
              backgroundColor: const Color(0xff3AC3E2),
              headerTextColor: Colors.black),
          onChangeDateTime: (datetime) {
            selectedData = datetime.toDateTime();
            setState(() {});
            print(datetime.toString());
          },
        ),
        StreamBuilder(
          stream: TasksDao.getTasksRealTimeUpdates(
              authProvider.databaseUser!.id!, selectedData),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // loading data
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text('SomeThing went wrong'),
                    ElevatedButton(onPressed: () {}, child: Text('Try again')),
                  ],
                ),
              );
            }
            // no loading - no error

            var tasksList = snapshot.data;

            return Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => TaskItem(
                task: tasksList![index],
              ),
              itemCount: tasksList?.length ?? 0,
            ));
          },
        )
      ],
    );
  }
}
