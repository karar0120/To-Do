
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/cubit/cubit.dart';

Widget DafultButton({
  double Aidth =double.infinity,
  Color Aackground=Colors.blue,
  required VoidCallback function,
  bool inuppuer=true,
  double x=0.0,
  BoxDecoration? e,
  BorderRadius? s,
  required String text ,
})=>Container(
    height: 40,
    width: Aidth,

    child:Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(x),
        color: Aackground,
      ),
      child:MaterialButton(
        onPressed:function,
        child: Text(inuppuer?text.toUpperCase():text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),),
    )
);


Widget Appbar({
  @required context,String? title,
List<Widget>?action,
})=>AppBar(
  leading:IconButton(
    icon: Icon(
      Icons.arrow_back_ios
    ),
    onPressed: (){
      Navigator.pop(context);
    },
  ) ,
  title: Text(title!),
  actions: action,
);



//Icons.remove_red_eye_sharp
Widget formfild({
  required TextEditingController controller,
  required String Text,
  required FormFieldValidator valudat,
  ValueChanged? onSubmit,
  ValueChanged? inChange,
  required IconData Iconsss,
  required TextInputType Keybord,
  bool abscure=false,
  IconData? suffix,
  VoidCallback? setstate,
  VoidCallback? onTap,
})=>TextFormField(
  controller:controller,
  decoration: InputDecoration(
    labelText: Text,
    border:OutlineInputBorder(),
    prefixIcon: Icon(
      Iconsss,
    ),
    suffixIcon: suffix!=null? IconButton(
      icon: Icon(suffix),
      onPressed: setstate,
    ):null,
  ),
  keyboardType: Keybord,
  onFieldSubmitted: onSubmit,
  onChanged: inChange,
  validator:valudat,
  obscureText:abscure ,
  onTap: onTap,
);

Widget  impBuild(Map module)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Row(

    children: [

      CircleAvatar(

        radius: 40,

        child: Text("${module["title"]}"),

      ),

      SizedBox(

        width: 20,

      ),

      Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          Text("${module["data"]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

          Text("${module["time"]}",style: TextStyle(fontSize: 20,color: Colors.grey),)

        ],

      )

    ],

  ),
);

Widget buildItemtodo(Map modal,context)=>Dismissible(
  key: Key(modal['id'].toString()),
  child:   Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

  children: [

  CircleAvatar(

  radius: 40,

  child: Text(modal['time']),

  ),

  SizedBox(

  width: 20.0,

  ),

  Expanded(

    child:   Column(

    mainAxisSize: MainAxisSize.min,

    children: [

    Text(

    modal['title'],

    style: TextStyle(

    fontSize: 18.0,

    fontWeight: FontWeight.bold

    ),

    ),

    Text(modal['data'],

    style: TextStyle(

    color: Colors.grey              ),

    )



    ],

    ),

  ),

    SizedBox(

      width: 20.0,

    ),

    IconButton(

        onPressed:(){

          todocubit.get(context).UpdatedataBase(status: "done", id:modal['id']);

        },

        icon: Icon(Icons.check_box,

        color: Colors.green,),

    ),

    IconButton(

      onPressed:(){

        todocubit.get(context).UpdatedataBase(status: "archive", id:modal['id']);

      },

      icon: Icon(Icons.archive,

        color: Colors.black45,),

    )



  ],

  ),

  ),
  onDismissed: (direction){
    todocubit.get(context).DeletdataBase(id: modal['id']);
  },
);


Widget taskBulider({required List <Map>tasks})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context,)=>ListView.separated(
      itemBuilder: (context,index)=>buildItemtodo(tasks[index],context),
      separatorBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey[300],
        ),
      ),
      itemCount: tasks.length
  ),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,size: 100,color: Colors.grey,),
        Text('No Task Yet !..Please Enter Your Tasks',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Colors.grey))
      ],
    ),
  ),
);

