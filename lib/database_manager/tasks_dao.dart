import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_tasks_app/database_manager/model/task.dart';
import 'package:daily_tasks_app/database_manager/user_dao.dart';

class TasksDao{
  static CollectionReference<Task> getTasksCollection(String uid){
    var userDoc = UserDao.getUsersCollection().doc(uid);
   return userDoc.collection(Task.collectionName).withConverter(
        fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()),
        toFirestore: (task, options) => task.toFireStore());
  }


static  Future<void> addTask(Task task, String uid){
    var docRef = getTasksCollection(uid).doc();
    task.id = docRef.id;
    return docRef.set(task);
  }
}