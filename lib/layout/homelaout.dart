// ignore_for_file: prefer_const_literals_to_create_immutables

//import 'dart:js';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todoapp/componats/fild.dart';
import 'package:todoapp/cubit/cubit.dart';
import 'package:todoapp/cubit/state.dart';
import 'package:todoapp/module/Arcive/Arcive.dart';
import 'package:todoapp/module/done/Arcive.dart';
import 'package:todoapp/module/tasks/tasks.dart';

class Homelayout extends StatelessWidget {
  int currentindex=0;



  var ScaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  var titlecontroller=TextEditingController();
  var timecontroller=TextEditingController();
  var datecontroller=TextEditingController();
  //List<Map>tasks=[];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>todocubit()..createdatadase(),
      child: BlocConsumer<todocubit,todostate>(
        listener: (context,state){

          if (state is insertdatebase){
            Navigator.pop(context);
          }
        },
        builder: (context,state){
          todocubit cubit=todocubit.get(context);
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
              title: Text(todocubit.get(context).Appbarname[todocubit.get(context).currentindex]),
            ),
            body:ConditionalBuilder(
              condition:true ,
              builder:(context) =>todocubit.get(context).screans[todocubit.get(context).currentindex],
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              child:Icon(cubit.fibicon),
              onPressed: (){
                if (cubit.isclose){
                  if (formKey.currentState!.validate()){
                   cubit.insertdata(title:titlecontroller.text, time: timecontroller.text, data:datecontroller.text);

                    /*insertdata(
                        title: titlecontroller.text,
                        time: timecontroller.text,
                        data: datecontroller.text).
                    then((value){
                      Navigator.pop(context);
                      /*setState(() {
                    fibicon=Icons.edit;
                  });*/

                      isclose=false;
                    });*/

                  }
                }
                else {
                  ScaffoldKey.currentState!.showBottomSheet((context)=>Container(
                      color: Colors.white,
                      padding: EdgeInsetsDirectional.all(20.0),
                      child:Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            formfild(
                                controller: titlecontroller,
                                Text: "Task Title",
                                valudat: (value) {
                                  if (value.isEmpty) {
                                    return "the task must not empty";
                                  }
                                },
                                Iconsss: Icons.title,
                                Keybord: TextInputType.text),
                            SizedBox(
                              height: 15,
                            ),
                            formfild(
                                onTap: () {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then((value) {
                                    timecontroller.text = value!.format(context);
                                  });
                                },
                                controller: timecontroller,
                                Text: "Task Time",
                                valudat: (value) {
                                  if (value.isEmpty) {
                                    return "the time must not empty";
                                  }
                                },
                                Iconsss: Icons.watch_later_outlined,
                                Keybord: TextInputType.datetime),
                            SizedBox(
                              height: 15,
                            ),
                            formfild(
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:DateTime.now(),
                                      lastDate: DateTime.parse("2022-02-25")).then((value) {
                                    datecontroller.text=DateFormat.yMMMd().format(value!);
                                  });
                                },
                                controller: datecontroller,
                                Text: "Task Date",
                                valudat: (value) {
                                  if (value.isEmpty) {
                                    return "the date must not empty";
                                  }
                                },
                                Iconsss: Icons.calendar_today,
                                Keybord: TextInputType.datetime),
                          ],
                        ),
                      ))).closed.then((value){
                   cubit.IconButton(
                       icon:Icons.edit,
                       isShow: false);


                  });
                  cubit.IconButton(
                      icon: Icons.add , isShow: true);
                }

              },
              elevation: 20.0,
            ),
            bottomNavigationBar: BottomNavigationBar
              (
              currentIndex:todocubit.get(context).currentindex ,
              onTap: (index){
                todocubit.get(context).changenumerwitheindex(index);
                //todocubit.get(context).currentindex=index;
              },
              items: [
                BottomNavigationBarItem(
                  icon:Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon:Icon(Icons.check_circle),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon:Icon(Icons.archive),
                  label: "Archive",
                ),

              ],

            ),
          );
        },
      )
    );
  }



}


