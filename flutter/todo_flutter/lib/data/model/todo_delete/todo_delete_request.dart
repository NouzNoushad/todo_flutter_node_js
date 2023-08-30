// To parse this JSON data, do
//
//     final todoDeleteResponse = todoDeleteResponseFromJson(jsonString);

import 'dart:convert';

TodoDeleteResponse todoDeleteResponseFromJson(String str) =>
    TodoDeleteResponse.fromJson(json.decode(str));

String todoDeleteResponseToJson(TodoDeleteResponse data) =>
    json.encode(data.toJson());

class TodoDeleteResponse {
  String id;

  TodoDeleteResponse({
    required this.id,
  });

  factory TodoDeleteResponse.fromJson(Map<String, dynamic> json) =>
      TodoDeleteResponse(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
