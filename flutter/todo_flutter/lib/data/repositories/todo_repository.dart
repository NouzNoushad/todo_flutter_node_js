import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_flutter/data/model/todo_add/todo_add_request.dart';
import 'package:todo_flutter/data/model/todo_add/todo_add_response.dart';
import 'package:todo_flutter/data/model/todo_delete/todo_delete_request.dart';
import 'package:todo_flutter/data/model/todo_list.dart';
import 'package:todo_flutter/utils/end_points.dart';

class TodoRepository {
  http.Client baseClient = http.Client();
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  Future<List<TodoListResponse>> getTodoList() async {
    List<TodoListResponse> todoList;
    Uri url = Uri.parse('${EndPoints.baseUrl}/${EndPoints.todoList}');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      List<TodoListResponse> todoListResponse =
          todoListResponseFromJson(response.body);
      debugPrint('//////////// get response : ${response.body}');
      todoList = todoListResponse;
    } else {
      throw Exception('Unable to fetch data');
    }
    return todoList;
  }

  Future<String> addTodo(TodoAddRequest addRequest) async {
    String message;
    Uri url = Uri.parse('${EndPoints.baseUrl}/${EndPoints.addOrUpdate}');
    var response = await http.post(url,
        body: todoAddRequestToJson(addRequest), headers: headers);
    if (response.statusCode == 200) {
      debugPrint('///////////// add response : ${response.body}');
      TodoAddResponse addResponse = todoAddResponseFromJson(response.body);
      message = addResponse.message;
    } else {
      throw Exception('Unable to add data');
    }
    return message;
  }

  Future<String> deleteTodo(String id) async {
    String message;
    Uri url = Uri.parse('${EndPoints.baseUrl}/${EndPoints.delete}');
    TodoDeleteResponse deleteResponse = TodoDeleteResponse(id: id);
    var response = await http.post(url,
        body: todoDeleteResponseToJson(deleteResponse), headers: headers);
    if (response.statusCode == 200) {
      debugPrint('///////////// delete response : ${response.body}');
      message = todoAddResponseFromJson(response.body).message;
    } else {
      throw Exception('Unable to delete data');
    }
    return message;
  }
}
