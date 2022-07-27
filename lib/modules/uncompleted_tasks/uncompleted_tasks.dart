import 'package:algoriza_todo_app/core/util/blocks/app/cubit.dart';
import 'package:algoriza_todo_app/core/util/blocks/app/states.dart';
import 'package:algoriza_todo_app/modules/completed_tasks/completed_tasks.dart';
import 'package:algoriza_todo_app/modules/favorite_tasks/favorite_tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnCompletedTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        // var tasks=AppCubit.get(context).completeTasks;

        return ListView.builder(
          itemBuilder: (context, index) {
            if(AppCubit.get(context).tasks[index]['status']=='Completed')
              return buildTaskItem(AppCubit.get(context).tasks[index]);
            else return Container();
          },
          itemCount: AppCubit.get(context).tasks.length,
        );
      },
    );
  }

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
                borderRadius: BorderRadius.circular(3),
              ),
              checkColor: Colors.yellow,
            ),
            const SizedBox(width: 7.0,),
            Text('${model['title']}',
              style: const TextStyle(
                fontSize:16,
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
                  onTap: (){
                    AppCubit.get(context).status=true;
                    AppCubit.get(context).upDateStatusData(status:AppCubit.get(context).status, id: model['id']);
                    AppCubit.get(context).getTasksData();
                  },
                ),
                PopupMenuItem(
                  child:
                  Text('Uncomplete',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),),
                  value:UnCompletedTasks(),
                  onTap: (){
                    AppCubit.get(context).status=false;
                    AppCubit.get(context).upDateStatusData(status:AppCubit.get(context).status, id: model['id']);
                  },
                ),
                PopupMenuItem(
                  child:
                  Text('Favorite',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),),
                  value:FavoriteTasks(),
                  onTap: (){
                    AppCubit.get(context).favorite=!AppCubit.get(context).favorite;
                    AppCubit.get(context).upDateFavorite(favorite:AppCubit.get(context).favorite, id: model['id']);
                  },

                ),
              ],
              child: const Icon(Icons.more_vert,
                size:25,),
            ),


          ],
        ),
      );
}
