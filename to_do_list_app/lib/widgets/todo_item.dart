import 'package:flutter/material.dart';
import 'package:to_do_list_app/constants/colors.dart';
import 'package:to_do_list_app/model/todo_model.dart';

class TodoItemScreen extends StatelessWidget {

  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const TodoItemScreen({super.key,required this.todo,required this.onToDoChanged,required this.onDeleteItem,});



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
           onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ?
          Icons.check_box :  Icons.check_box_outline_blank, color: AppColors.tdBlue,),

        title: Text(todo.todoText!,

          style: TextStyle(fontSize: 16,
            color: AppColors.tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null ,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: AppColors.tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: (){
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
