import 'package:flutter/material.dart';
import 'package:to_do_list_app/constants/colors.dart';
import 'package:to_do_list_app/widgets/todo_item.dart';
import 'model/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
   _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppColors.tdBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.tdBGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           const Icon(
              Icons.menu,
              color:
              AppColors.tdBlack,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.network('https://images.pexels.com/photos/53435/tree-oak-landscape-view-53435.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    fit: BoxFit.cover
                ),
              )
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(

              children: [

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.tdBlack,
                      ),
                      prefixIconConstraints: BoxConstraints(maxHeight: 20,
                        maxWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: AppColors.tdGrey),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50,bottom: 20),
                        child: const Text('All ToDos',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                      ),
                      for( ToDo todoo in _foundToDo)

                        TodoItemScreen(todo: todoo,
                        onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),

                    ],
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: const  EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                     boxShadow: const [BoxShadow(color: Colors.grey,offset: Offset(0.0,0.0),
                         blurRadius: 10.0,spreadRadius: 0.0,
                     )],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new item',
                      border: InputBorder.none
                    ),
                  ),
                ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  // child: ElevatedButton(
                  //   child: Text('+',style: TextStyle(fontSize: 40),),
                  //   onPressed: (){
                  //
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //
                  //   ),
                  // )
                  child: GestureDetector(
                    onTap: (){
                      _addToDItem(_todoController.text);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColors.tdBlue
                      ),
                      child: const Center(child: Text('+',style: TextStyle(fontSize: 36,color: Colors.white),)),
                    ),
                  ),

                )
              ],
            ),
          )
        ],
      )
    );
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });


  }
  void _deleteToDoItem(String id){

   setState(() {
     todosList.removeWhere((item) => item.id == id);
   });
  }

  void _addToDItem(String todo){
    setState(() {
      todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
  _todoController.clear();
  }

  void _runFilter(String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty){
      results = todosList;
    } else {
      results = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

}


