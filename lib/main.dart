import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/componats/Bloc.observer.dart';
import 'package:todoapp/layout/homelaout.dart';

void main() {

  BlocOverrides.runZoned(
        () {
      runApp(MyApp());
    },
    blocObserver:MyBlocObserver() ,
  );
 //Bloc. observer = ;
  //runApp( MyApp());


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homelayout()
    );
  }
}

