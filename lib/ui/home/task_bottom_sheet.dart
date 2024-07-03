import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_tasks_app/database_manager/model/task.dart';
import 'package:daily_tasks_app/database_manager/tasks_dao.dart';
import 'package:daily_tasks_app/providers/authentication_provider.dart';
import 'package:daily_tasks_app/ui/components/custom_text_form-field.dart';
import 'package:daily_tasks_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            CustomTextFormField(
              controller: titleController,
              labelText: 'Task Title',
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Plz, enter task title';
                }
                return null;
              },
            ),
            CustomTextFormField(
              controller: descriptionController,
              labelText: 'Task Description',
              maxLines: 4,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Plz, enter task description';
                }
                return null;
              },
            ),
            InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Text(
                  finalSelectedDate == null ? 'Select Date' : '${finalSelectedDate?.day} / ${finalSelectedDate?.month} / ${finalSelectedDate?.year}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline),
                )),
            Visibility(
                visible: showDateError,
                child: Text(
                  'Plz,selectDate',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                )),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text('Add Task'))
          ],
        ),
      ),
    );
  }

  bool isValidForm(){
    bool isValid = true;
    if(formKey.currentState?.validate() == false){
     isValid = false;
    }
    if(finalSelectedDate == null){
      setState(() {
        showDateError = true;
      });

      isValid = false;
    }
    return isValid;
  }

  addTask() async{

    var authProvider = Provider.of<AuthenticationProvider>(context,listen: false);
    if (!isValidForm()) {
      return;
    }
    Task task = Task(
      title: titleController.text,
      description: descriptionController.text,
      dateTime: Timestamp.fromMillisecondsSinceEpoch(
            finalSelectedDate!.millisecondsSinceEpoch));
   try{
     DialogUtils.showLoadingDialog(context, 'Loading...');
     await  TasksDao.addTask(task, authProvider.databaseUser!.id!);
     DialogUtils.hideDialog(context);
     DialogUtils.showMessage(context, 'Task added successfully', posActionTitle: 'Ok', posAction: (){
       Navigator.pop(context);
     });

   }catch(e){
     DialogUtils.hideDialog(context);
     DialogUtils.showMessage(context, 'SomeThing went wrong, ${e.toString()}', posActionTitle: 'Ok',);
   }

  }

  DateTime? finalSelectedDate;
  bool showDateError = false;

  void showTaskDatePicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (date != null) {
      finalSelectedDate = date;
      showDateError = false;
      setState(() {});
    }
  }
}
