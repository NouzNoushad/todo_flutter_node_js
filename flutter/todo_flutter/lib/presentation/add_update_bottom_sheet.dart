import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data/bloc/todo_list_bloc/todo_list_bloc.dart';
import '../data/model/todo_add/todo_add_request.dart';
import '../data/model/todo_list.dart';
import '../utils/constant.dart';
import '../widgets/text_fields.dart';

TextEditingController idController = TextEditingController();
TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();

addOrUpdateTodo(
    {required BuildContext context,
    TodoListResponse? todo,
    required TodoType todoType}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: idController,
                  hintText: todoType == TodoType.update
                      ? todo!.todoListResponseId
                      : 'ID',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: titleController,
                  hintText: todoType == TodoType.update ? todo!.title : 'Title',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: contentController,
                  hintText:
                      todoType == TodoType.update ? todo!.content : 'Content',
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        String id = idController.text;
                        String title = titleController.text;
                        String content = contentController.text;
                        if (todoType == TodoType.update) {
                          id = id != '' ? id : todo!.todoListResponseId;
                          title = title != '' ? title : todo!.title;
                          content = content != '' ? content : todo!.content;
                        }
                        if (id != '' && title != '' && content != '') {
                          TodoAddRequest addRequest = TodoAddRequest(
                              id: id.padLeft(4, '0'),
                              userId: 'abc@gmail.com',
                              title: title,
                              content: content);
                          context
                              .read<TodoListBloc>()
                              .add(TodoAddEvent(addRequest));
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'All fields are required');
                        }
                        idController.text = '';
                        titleController.text = '';
                        contentController.text = '';
                      },
                      child: Text(
                        todoType == TodoType.update ? 'Update' : 'Save',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}
