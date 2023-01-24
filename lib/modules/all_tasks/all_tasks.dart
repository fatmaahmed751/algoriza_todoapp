import 'package:algoriza_todo_app/core/models/build_task_model.dart';
import 'package:algoriza_todo_app/core/util/blocks/app/cubit.dart';
import 'package:algoriza_todo_app/core/util/blocks/app/states.dart';
import 'package:algoriza_todo_app/modules/completed_tasks/completed_tasks.dart';
import 'package:algoriza_todo_app/modules/favorite_tasks/favorite_tasks_screen.dart';
import 'package:algoriza_todo_app/modules/uncompleted_tasks/uncompleted_tasks.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tasks = AppCubit
        .get(context)
        .tasks;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: tasks.isNotEmpty,
            builder: (BuildContext context) =>
                ListView.separated(
                  itemBuilder: (BuildContext context, int index) =>
                      buildTaskItem(
                        model:  tasks[index],context:context),
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                        height: 0.0,
                      ),
                  itemCount: tasks.length

                ),
            fallback: (BuildContext context) =>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: 500,
                            height: 450,
                            child: const FittedBox(
                              fit: BoxFit.cover,
                              child: Image(
                                image: AssetImage('assets/images/task.jpg'),
                                // alignment: Alignment.center,
                                //  fit:BoxFit.cover,
                                height: 300,
                                width: 300,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text('No Tasks Yet',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0
                          ),),
                      ],
                    ),
                  ),
                ),
          );
        }
    );
  }

    Widget buildTaskItem({
      required BuildTaskModel model, context}) =>
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
           //   AppCubit.get(context).upDateCompleted(model.id);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    AppCubit.get(context).upDateCompleted(model.id);
                    print(model.id);
                  },
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:Colors.green,
                            width: 1.0
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:model.completed==1?
                    const  Icon(
                      Icons.check,
                      color: Colors.black,
                      size: 20.0,
                    )
                        : Container(),
                  ),

                ),
                const SizedBox(width: 9.0),
                Text
                  (model.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),),
                const Spacer(),
                PopupMenuButton(
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                      value: CompletedTasks(),
                      onTap: () {
                        AppCubit.get(context).upDateCompleted(model.id);
                        print(model.id);
                      },
                      child:
                      const Text('complete',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),),
                    ),
                    PopupMenuItem(
                      value: UnCompletedTasks(),
                      onTap: () {
                        AppCubit.get(context).upDateCompleted(model.id);
                      },
                      child:
                      const Text('Uncomplete',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),),
                    ),
                    PopupMenuItem(
                      value:FavoriteTasks(),
                      onTap: () {
                        AppCubit.get(context).upDateFavorite(model.id);
                      },
                      child:
                      const Text('Favorites',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),),

                    ),
                  ],
                  child: const Icon(Icons.more_vert,
                    size: 25,),
                ),


              ],
            ),
          ),
        );
  }

