import 'package:demo/screens/database_helper.dart';
import 'package:demo/screens/task_model.dart';
import 'package:flutter/material.dart';



class CustomAlert extends StatelessWidget {
    final CustomerModel?customer;
    final VoidCallback rebuild;
   CustomAlert({
    Key? key,this.customer,
    required this.rebuild,
  }) : super(key: key);

 
DatabaseHelper _dbHelper=DatabaseHelper();



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    title: Text("Are you sure?"),
    content: Text("You want to delete this task permanently"),
    actions: [
        TextButton(
         onPressed: () async {
              if (customer!=null) {
                await _dbHelper.deleteTask(
              customer!.id!);
              Navigator.pop(context);
              rebuild();
              }
            },
        child: Text("Yes")
        ),
         TextButton(
        onPressed: (){
          Navigator.pop(context);
        }, 
        child: Text("No")
        ),
    ],
    );
  }
}

