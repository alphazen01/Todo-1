import 'package:demo/screens/custom_alert.dart';
import 'package:demo/screens/database_helper.dart';
import 'package:demo/screens/task_page.dart';
import 'package:demo/screens/widget.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff7349FE),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Create your Notes",
            style: TextStyle(fontSize: 24,color: Colors.white),
          ),
        ),
        body: Container(
          width: double.infinity,
          // color: Color(0xffF6F6F6),
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 32),
                child: Image(image: AssetImage("assets/logo.png")),
              ),
              Expanded(
                child: FutureBuilder<List>(
                  initialData: [],
                    future: _dbHelper.getTask(),
                    builder: (context, snapshot) {
                      print(snapshot.data!.length);
                      return ListView.separated(
                        itemBuilder: (context,index){
                          return  Row(
                              children: [
                                Text((index+1).toString(),style: TextStyle(fontSize: 20,color: Colors.white),),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: TaskCardWidget(
                                    title: snapshot.data![index].title,
                                    description: snapshot.data![index].description,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context, MaterialPageRoute(builder: (_)=>TaskPage(rebuild: rebuild,customer: snapshot.data![index],))
                                      );
                                  }, 
                                  icon: Icon(Icons.edit,color: Colors.white,size: 30,)
                                ),
                                IconButton(
                                    onPressed: () {
                                       showDialog(
                                        barrierDismissible: false,
                                      context: context, 
                                      builder:(BuildContext context){
                                        return CustomAlert(
                                          customer: snapshot.data![index], 
                                          rebuild: rebuild
                                        );
                                      } 
                                      );
                                    },
                                    icon: Icon(Icons.delete,color: Colors.red,size: 30,),
                                )
                              ],
                            );
                           },
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20,);
                          });
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
              builder: (_) => TaskPage(
              rebuild: rebuild,
            )));
          },
          backgroundColor: Color(0xff7349FE),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

