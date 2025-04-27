import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Add a new task to the Firestore collection
  Future<void> addTask(
    String title,
    String? description,
    String priority,
  ) async {
    await firestore.collection('tasks').add({
      'title': title,
      'description': description,
      'priority': priority,
      'createdAt': FieldValue.serverTimestamp(),
      'isCompleted': false,
    });
  }

  // Fetch all tasks from the Firestore collection
  Stream<QuerySnapshot> getTasks() => firestore.collection('tasks').snapshots();
}
