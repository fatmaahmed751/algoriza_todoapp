import 'package:algoriza_todo_app/modules/completed_tasks/completed_tasks.dart';
import 'package:algoriza_todo_app/modules/favorite_tasks/favorite_tasks_screen.dart';
import 'package:algoriza_todo_app/modules/uncompleted_tasks/uncompleted_tasks.dart';
import 'package:flutter/material.dart';

Widget defaultLine()=>  Container(
width: double.infinity,
height: 0.8,
color: Colors.grey[500],
child: const Divider(
//width: double.infinity,
),
);

Widget DefaultButton({
   required String text,
  required Function function,
})=>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width:double.infinity,
         height: 40.0,
         decoration:  BoxDecoration(
           borderRadius: BorderRadius.circular(10.0),

            color: Colors.greenAccent.shade700,
         ),
        child: TextButton(
          onPressed: () {
            function();
          }, child:Text(text,
          style: const TextStyle(
            color: Colors.white,

          ),
        ),

        ),
      ),
    );

Widget subTitle({
required String text})=>
    Text(
     text,
      style: const TextStyle(
        fontSize:15 ,
        fontWeight: FontWeight.w700,
      ),
);

Widget appBarIcon({
  required Function function,
  required Icon icon,
})=> IconButton(
  onPressed: () {
    function();
  },
  icon:icon,
);

Widget defaultFormField( {
   TextEditingController? controller,
   TextInputType? type,
    String? hint,
   String? text,
  BorderRadius? radius,
  IconButton? icon,
 Widget? suffixWidget,

})=>
    Container(
      height: 40,
      child: TextFormField(
        enabled: true,
       readOnly:false ,
         controller:controller,
        keyboardType: type,
        decoration: InputDecoration(
          suffixIcon: icon,
          hintText: hint,
      suffix: suffixWidget,
      labelText: text,
      fillColor: Colors.grey[100],
          filled: true,
          enabled: false,
          border: OutlineInputBorder(
            borderRadius:radius!,
          ),
        ),
      ),
    );

Widget buildTaskItem(Map model,{
  bool checkValue=false,
 //  Future changeValue,
})=>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Checkbox(
               value:checkValue,
               onChanged:(value){
               },
           shape:RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(4),
           ),
             activeColor: Colors.yellow,
           ),
          const SizedBox(width: 7.0,),
          Text('${model['title']}',
          style: const TextStyle(
            fontSize:18,
            color: Colors.black87,
          ),),
          const Spacer(),
          PopupMenuButton(
            itemBuilder: (context)=>[
              PopupMenuItem(
               child:
              const Text('complete',
              style: TextStyle(
                fontSize: 12.0,
              ),),
              value:CompletedTasks(),

            ),
              PopupMenuItem(
                child:
                 Text('Uncomplete',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),),
                value:UnCompletedTasks(),
              ),
              PopupMenuItem(
                child:
                 Text('Favorite',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),),
                value:FavoriteTasks(),
                onTap: (){
                 // AppCubit.get(context).isFavorite
                },

              ),
            ],
            child: const Icon(Icons.more_vert,
            size:25,),
          ),


],
      ),
    );

 Widget buildScheduleItem(Map model)=>
     Container(
       margin: EdgeInsets.symmetric(
         horizontal: 10.0,
       ),
       height: 70,
       decoration: BoxDecoration(
         color:model['color']==0 ?Colors.yellow : model['color']==1 ?Colors.red :model['color']==2 ?Colors.blueAccent :Colors.deepOrange,
         borderRadius: BorderRadius.circular(15.0),
       ),
       child: Padding(
         padding: const EdgeInsets.all(13.0),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                Text('${model['startTime']}',
               textAlign: TextAlign.start,
               style: TextStyle(

                 color: Colors.white,
                 fontSize: 16,
               ),),
               SizedBox(height: 5.0,),
               Row(
                 children: [
                    Text('${model['title']}',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                   ),),
                   const Spacer(),

                Icon(Icons.check_circle_outline_sharp,
                     color: Colors.white,
                      size: 16,)

                 ],
               ),
             ],
           ),
         ),
       ),
     );

