// To parse this JSON data, do
//
//     final todoAddResponse = todoAddResponseFromJson(jsonString);

import 'dart:convert';

TodoAddResponse todoAddResponseFromJson(String str) =>
    TodoAddResponse.fromJson(json.decode(str));

String todoAddResponseToJson(TodoAddResponse data) =>
    json.encode(data.toJson());

class TodoAddResponse {
  String message;

  TodoAddResponse({
    required this.message,
  });

  factory TodoAddResponse.fromJson(Map<String, dynamic> json) =>
      TodoAddResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
