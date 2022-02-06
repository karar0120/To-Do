//import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todoapp/componats/fild.dart';
import 'package:todoapp/cubit/state.dart';
import 'package:todoapp/module/Arcive/Arcive.dart';
import 'package:todoapp/module/done/Arcive.dart';
import 'package:todoapp/module/tasks/tasks.dart';

class todocubit extends Cubit<todostate>{
  todocubit() : super(initialState());
  static todocubit get(context)=>BlocProvider.of(context);

  int currentindex=0;
  Database ?database;
  bool isclose=false;
  IconData fibicon=Icons.edit;

  List<Map>donetasks=[];
  List<Map>newtasks=[];
  List<Map>arcivetasks=[];
  List<Widget>screans=[

    Tasks(),
    done(),
    Arcive(),

  ];
  List<String>Appbarname=[
    "Tasks",
    "Done",
    "Arcived",
  ];

  void changenumerwitheindex(index){
    currentindex=index;
    emit(ChangeNavBottomState());
  }


  void createdatadase(){
     openDatabase(
        'todo.db',
        version:1,
        onCreate: (database,version){
          print ("onCreate is done");
          database.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT,data TEXT,time TEXT, status TEXT  )").then((value){
            print ("table create is done");
          }).catchError((error){
            print ("the erorr is ${error.toString()}");
          });
        },
        onOpen: (database){
          getdata(database);
          print ("on open is done");
        }
    ).then((value){
      database=value;
      emit(createdatebase());
     });

  }
   insertdata({required String title,required String time,required String data} ) async{
    await database!.transaction((txn)=>
        txn.rawInsert(
            'INSERT INTO tasks (title,data,time,status) VALUES ("$title","$data","$time","New")').then((value){

          print ("the insert is done${value}");
          emit(insertdatebase());
          getdata(database);

        }).catchError((error){
          print ("errorssssss${error.toString()}");
        })).then((value){
      // print ("the inset is done");
    });
  }

 void  getdata(database){


   newtasks=[];
   donetasks=[];
   arcivetasks=[];
    database!.rawQuery("SELECT * FROM tasks").then((value){

      value.forEach((element){
        print (element['status']);
        if (element['status']=='New'){
          newtasks.add(element);
        }
        else if(element['status']=='done'){
          donetasks.add(element);
        }
        else {
          arcivetasks.add(element);
        }
        print (element['status']);
      });
      emit(getdatebase());
    });
  }


  void UpdatedataBase({required String status,required int id}) async{
     database!.rawUpdate(
        'UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', id]).then((value){
      getdata(database);
      emit(Appupdatedata());
    });
  }
  void IconButton({
  required IconData icon,
    required bool isShow,
}){
     isclose=isShow;
     fibicon=icon;
     emit(changeIcon());
  }


  void DeletdataBase({required int id}) async{
    await database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getdata(database);
      emit(Appdeletdata());
    });
  }

}