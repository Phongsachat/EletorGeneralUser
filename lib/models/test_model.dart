// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

TestModel userFromJson(String str) => TestModel.fromJson(json.decode(str));

String userToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  TestModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
