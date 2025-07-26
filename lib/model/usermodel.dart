import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.id,
    required this.pic,
    required this.task,
  });

  late final String name;
  late final String id;
  late final String pic;
  late final List<String> task;

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    id = json['id'] ?? '';
    pic = json['pic'] ?? '';
    task = List<String>.from(json['task'] ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'pic': pic,
      'task': task,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel.fromJson(snapshot);
  }
}
