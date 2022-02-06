
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/componats/fild.dart';
import 'package:todoapp/cubit/cubit.dart';
import 'package:todoapp/cubit/state.dart';

class Arcive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<todocubit,todostate>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=todocubit.get(context).arcivetasks;
        return taskBulider(
            tasks: cubit
        );
      },
    );
  }
}
