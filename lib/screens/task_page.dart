import 'dart:math';

import 'package:demo/screens/custom_alert.dart';
import 'package:demo/screens/database_helper.dart';
import 'package:demo/screens/task_model.dart';
import 'package:flutter/material.dart';


class TaskPage extends StatefulWidget {
  final CustomerModel?customer;
  const TaskPage({
    Key? key,
    required this.rebuild,
    this.customer
  }) : super(key: key);
  final VoidCallback rebuild;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
   DatabaseHelper _dbHelper = DatabaseHelper();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  int customerId = 0;

  @override
  void initState() {
  
    super.initState();
   if (widget.customer!=null) {
      titleEditingController.text=widget.customer!.title!;
    descriptionEditingController.text=widget.customer!.description!;
   }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  
                  color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,)),
                      // SizedBox(width: 10,),
                      Expanded(
                          child: TextField(
                        controller: titleEditingController,
                        decoration: InputDecoration(
                            hintText: "Enter Task Title",
                            border: InputBorder.none),
                        style: TextStyle(fontSize: 26, color: Color(0xff211551)),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height:400,
                  
                  decoration: BoxDecoration(
                   color: Color(0xff7349FE),
                   borderRadius: BorderRadius.circular(20)
                  ),
                  child: TextField(
                    maxLines: 10,
                    controller: descriptionEditingController,
                    decoration: InputDecoration(
                    hintText: "Enter description for the task....",
                    border: InputBorder.none,
                      ),
                    style: TextStyle(fontSize: 20, color: Color(0xff211551)),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
              SizedBox(
                width: 70,
                child: ElevatedButton(
                   style:ElevatedButton.styleFrom(
                     primary: Color(0xff7349FE),
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )  
                      ) ,
                      onPressed: () async {
                        setState(() {
                        });
                        if (widget.customer==null) {
                           final customer = CustomerModel(
                          title: titleEditingController.text,
                          description: descriptionEditingController.text,
                        );
                        await DatabaseHelper.instance.insertTask(customer);
                        Navigator.pop(context);
                        widget.rebuild();
                        print("Done");
                        } else {
                          print("Can not save");
                        }


                        // final customer = CustomerModel(
                        //   title: titleEditingController.text,
                        //   description: descriptionEditingController.text,
                        // );
                        // await DatabaseHelper.instance.insertTask(customer);
                        // Navigator.pop(context);
                        // widget.rebuild();
                      },
                      child: Text("Save"),
                   ),
              ),
              SizedBox(width: 5,),
                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: Color(0xff7349FE),
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ) 
                    ) ,
                    onPressed:() async{
                      final customer = CustomerModel(
                        id: widget.customer!.id,
                        title: titleEditingController.text,
                        description: descriptionEditingController.text,
                      );
                      await DatabaseHelper.instance.updateTask(customer);
                      titleEditingController.clear();
                       Navigator.pop(context);
                      widget.rebuild();
                     },
                     child: Text(
                       "Update",
                       style: TextStyle(fontSize: 12),
                     ), 
                   ),
                  SizedBox(width:10),
            FloatingActionButton(
              onPressed: ()  {
                showDialog(
                barrierDismissible: false,
              context: context, 
              builder:(BuildContext context){
                return CustomAlert(
                  customer: widget.customer, 
                  rebuild: (){
                    Navigator.pop(context);
                    widget.rebuild();
                  }
                );
              } 
              );
            },
              backgroundColor: Color(0xFFFE3577),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Icon(Icons.delete_forever),
            ),
          ],
        ),
      ),
    );
  }
}
