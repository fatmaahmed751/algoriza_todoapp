import 'package:algoriza_todo_app/core/models/build_task_model.dart';
import 'package:algoriza_todo_app/core/util/blocks/app/cubit.dart';
import 'package:algoriza_todo_app/core/util/blocks/app/states.dart';
import 'package:algoriza_todo_app/modules/favorite_tasks/favorite_tasks_screen.dart';
import 'package:algoriza_todo_app/modules/uncompleted_tasks/uncompleted_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

         //var tasks=AppCubit.get(context).completeTasks;

        return ListView.builder(
          itemBuilder: (context, index) {
              return buildTaskItem(
                  AppCubit.get(context).tasks.where((element) =>element.completed==1).toList()[index] ,context);
            //else return Container();
          },
          itemCount: AppCubit.get(context).tasks.where((element) =>element.completed==1).toList().length,
        );

      },
    );

  }
  Widget buildTaskItem(BuildTaskModel model,context
   // bool checkValue=false,
    //  Future changeValue,
  )=>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(

          onTap: (){
            AppCubit.get(context).upDateCompleted(model.id);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){},
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.red,
                          width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(width:9.0,),
              Text('${model.title}',
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
                      AppCubit.get(context).completeTasks;
                      /*
                      AppCubit.get(context).status=true;
                      AppCubit.get(context).upDateStatusData(status:AppCubit.get(context).status, id: model['id']);
                      AppCubit.get(context).getTasksData();

                       */
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
                      AppCubit.get(context).completeTasks;
                    //  AppCubit.get(context).status=false;
                     // AppCubit.get(context).upDateStatusData(status:AppCubit.get(context).status, id: model['id']);
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
                      AppCubit.get(context).favoriteTasks;
                     // AppCubit.get(context).favorite=!AppCubit.get(context).favorite;
                    //  AppCubit.get(context).upDateFavorite(favorite:AppCubit.get(context).favorite, id: model['id']);
                    },

                  ),
                ],
                child: const Icon(Icons.more_vert,
                  size:25,),
              ),


            ],
          ),
        ),
      );
}
