import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
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
                print('Hello');
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
                  Text('Task Title'),
                  Text('Task Description'),
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
}
