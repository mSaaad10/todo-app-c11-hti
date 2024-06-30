import 'package:daily_tasks_app/ui/components/task_item.dart';
import 'package:flutter/material.dart';

class TasksListTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TaskItem(),
        TaskItem(),
        TaskItem(),
        TaskItem(),
        TaskItem(),
      ],
    );
  }
}
