// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_simple_app/core/services/snack_bar_service.dart';
import 'package:todo_simple_app/core/utiles.dart';
import 'package:todo_simple_app/model/task_model.dart';

class FireBaseUtils {
  static CollectionReference<TaskModel> getCollectionRef() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) => TaskModel.fromFirestore(snapshot.data()!),
      toFirestore: (taskModel, _) => taskModel.toFirestore(),
    );
  }

  static Future<void> addTaskToFireStore(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Stream<List<TaskModel>> getOnTimeReadFromFireStore(
      DateTime selectedDate) {
    var collectionRef = getCollectionRef().where("selectedDate",
        isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch);
    return collectionRef
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // static Future<List<TaskModel>> getOnTimeReadFromFireStore(DateTime selectedDate) async {
  //   var collectionRef = getCollectionRef().where("selectedDate",isEqualTo:extractDate(selectedDate).millisecondsSinceEpoch);
  //   // var date = await collectionRef.get();
  //   QuerySnapshot<TaskModel> data = await collectionRef.get();
  //   var taskList = data.docs.map((e) => e.data()).toList();
  //   return taskList;
  // }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDateFromFirestore(
      DateTime selectedDate) {
    var collectionRef = getCollectionRef().where("selectedDate",
        isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch);
    return collectionRef.snapshots();
  }

  static Future<void> deleteTask(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.delete();
    // return collectionRef.get().then((QuerySnapshot<TaskModel> snapshot) {
    //   snapshot.docs.forEach((doc) => doc.reference.delete());
    // });
  }

  static Future<void> updateTask(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    taskModel.isDone = true;
    return docRef.update(
      taskModel.toFirestore(),
    );
  }

  static Future<void> editTask(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);

    // Update the task document with the new data
    return docRef.update({
      'title': taskModel.title,
      'description': taskModel.description,
      // Add any other fields you need to update
    });
  }

  static Future<bool> createAccount(String emailAddress,
      String password) async {
    try {
      EasyLoading.show();
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.uid);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.dismiss();
        print('The password provided is too weak.');
        SnackBarService.showSuccessMessage("The password provided is too weak");
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.dismiss();
        print('The account already exists for that email.');
        SnackBarService.showSuccessMessage(
            "The account already exists for that email.");
        return Future.value(false);
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      return Future.value(false);
    }
    return Future.value(false);
  }

  static Future<bool> signAccount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.dismiss();
        print('No user found for that email.');
        SnackBarService.showErrorMessage("No user found for that email.");
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        EasyLoading.dismiss();
        print('Wrong password provided for that user.');
        SnackBarService.showErrorMessage(
            "Wrong password provided for that user.");
        return Future.value(false);
      }
    }
    return Future.value(false);
  }

  static Future<bool> signOut() async {
    try {
      EasyLoading.show(status: 'Signing out...');
      await FirebaseAuth.instance.signOut();
      EasyLoading.dismiss();
      SnackBarService.showSuccessMessage("Successfully signed out.");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      print('Error signing out: $e');
      SnackBarService.showErrorMessage("Error signing out. Please try again.");
      return Future.value(false);
    } catch (e) {
      EasyLoading.dismiss();
      print('Unexpected error: $e');
      SnackBarService.showErrorMessage(
          "Unexpected error occurred. Please try again.");
      return Future.value(false);
    }
  }
// Future<void> signOut() async {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   try {
//     await auth.signOut();
//   } catch (e) {
//     // Handle error
//     print('Error signing out: $e');
//   }
// }
}
