import 'package:daily_tasks_app/database_manager/model/task.dart';
import 'package:daily_tasks_app/database_manager/tasks_dao.dart';
import 'package:daily_tasks_app/providers/authentication_provider.dart';
import 'package:daily_tasks_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
          extentRatio: .2,
          children: [
            SlidableAction(
              spacing: 0.01,
              flex: 1,
              autoClose: true,
              onPressed: (context) {
                removeTask(widget.task);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
          motion: const DrawerMotion()),
      endActionPane: ActionPane(
        extentRatio: .2,

        motion: DrawerMotion(),
        children: [
          SlidableAction(

            onPressed: (context) {},
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.symmetric(horizontal: 18),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              width: 2,
              height: 65,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.task.title ?? ''),
                  Text(widget.task.description ?? ''),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).primaryColor),
              child: Icon(
                Icons.check,
                color: Colors.white,
                weight: 80,
                size: 26,
              ),
            )
          ],
        ),
      ),
    );
  }

  void removeTask(Task task) {
    DialogUtils.showMessage(context, 'Are u Sure u want to delete this task?',
        posActionTitle: 'Confirm', negActionTitle: 'No', posAction: () {
      deleteTask(task);
    });
  }

  void deleteTask(Task task) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    // delete Task From db
    DialogUtils.showLoadingDialog(context, 'Deleting task..');
    await TasksDao.deleteTaskFromDatabase(
        authProvider.databaseUser!.id!, task.id!);

    DialogUtils.hideDialog(context);
    DialogUtils.showMessage(context, 'Task Deleted Successfully',
        posActionTitle: 'Ok',
        posAction: () {},
        negActionTitle: 'Undo', negAction: () {
      // undo logic
    });
  }
}
