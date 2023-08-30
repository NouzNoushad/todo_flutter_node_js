// To parse this JSON data, do
//
//     final todoAddRequest = todoAddRequestFromJson(jsonString);

import 'dart:convert';

TodoAddRequest todoAddRequestFromJson(String str) =>
    TodoAddRequest.fromJson(json.decode(str));

String todoAddRequestToJson(TodoAddRequest data) => json.encode(data.toJson());

class TodoAddRequest {
  String id;
  String userId;
  String title;
  String content;

  TodoAddRequest({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
  });

  factory TodoAddRequest.fromJson(Map<String, dynamic> json) => TodoAddRequest(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "content": content,
      };
}
