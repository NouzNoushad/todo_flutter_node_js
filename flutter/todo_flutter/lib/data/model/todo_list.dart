// To parse this JSON data, do
//
//     final todoListResponse = todoListResponseFromJson(jsonString);

import 'dart:convert';

List<TodoListResponse> todoListResponseFromJson(String str) =>
    List<TodoListResponse>.from(
        json.decode(str).map((x) => TodoListResponse.fromJson(x)));

String todoListResponseToJson(List<TodoListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoListResponse {
  String id;
  String todoListResponseId;
  String userId;
  String title;
  String content;
  DateTime dateAdded;
  int v;

  TodoListResponse({
    required this.id,
    required this.todoListResponseId,
    required this.userId,
    required this.title,
    required this.content,
    required this.dateAdded,
    required this.v,
  });

  factory TodoListResponse.fromJson(Map<String, dynamic> json) =>
      TodoListResponse(
        id: json["_id"],
        todoListResponseId: json["id"],
        userId: json["userId"],
        title: json["title"],
        content: json["content"],
        dateAdded: DateTime.parse(json["dateAdded"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": todoListResponseId,
        "userId": userId,
        "title": title,
        "content": content,
        "dateAdded": dateAdded.toIso8601String(),
        "__v": v,
      };
}
