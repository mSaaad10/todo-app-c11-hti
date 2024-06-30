import 'package:daily_tasks_app/database_manager/model/user.dart' as MyUser;
import 'package:daily_tasks_app/database_manager/user_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier{
  MyUser.User? databaseUser;
  User? firebaseAuthUser;
  Future<void> register(String email, String password, String userName, String fullName)async{
    var credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email, password: password);

    MyUser.User user = MyUser.User(
      id: credential.user!.uid,
      userName:userName,
      fullName: fullName,
      emailAddress: email,
    );
    await UserDao.addUser(user);

  }

  Future<void> login(String email , String password)async{
    var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);

    databaseUser = await UserDao.getUser(result.user!.uid);
    firebaseAuthUser = result.user;
  }
}