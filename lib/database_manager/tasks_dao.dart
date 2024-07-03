import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_tasks_app/database_manager/model/task.dart';
import 'package:daily_tasks_app/database_manager/user_dao.dart';

class TasksDao{
  static CollectionReference<Task> getTasksCollection(String uid){
    var userDoc = UserDao.getUsersCollection().doc(uid);
   return userDoc.collection(Task.collectionName).withConverter(
        fromFirestore: (snapshot, options) =>
            Task.fromFireStore(snapshot.data()),
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTask(Task task, String uid) {
    var docRef = getTasksCollection(uid).doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<Task>> getAllTasks(String uid) async {
    var snapShot = await getTasksCollection(uid).get();
    var tasksList = snapShot.docs
        .map(
          (snapShot) => snapShot.data(),
        )
        .toList();
    return tasksList;
  }

  // static Stream<List<Task>>getTasksRealTimeUpdates(String uid)async*{
  //   var tasksSnapShot = getTasksCollection(uid).snapshots();
  //   var tasksList = tasksSnapShot.map((tasksCollectionSnapshot) =>tasksCollectionSnapshot.docs
  //       .map((taskSnapshot) => taskSnapshot.data(),).toList() ,);
  //   yield* tasksList;
  // }

  static Stream<List<Task>> getTasksRealTimeUpdates(
      String uid, DateTime selecteDate) async* {
    var tasksCollection =
        getTasksCollection(uid).where(isEqualTo: selecteDate, 'dateTime');
    var snapshot = tasksCollection.snapshots();
    var tasksList = snapshot.map(
      (querySnapShot) => querySnapShot.docs
          .map(
            (obj) => obj.data(),
          )
          .toList(),
    );
    yield* tasksList;
  }

  static Future<void> deleteTaskFromDatabase(String uid, String id) {
    var tasksCollection = getTasksCollection(uid);
    return tasksCollection.doc(id).delete();
  }
}