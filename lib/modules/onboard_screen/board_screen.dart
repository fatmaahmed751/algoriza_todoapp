import 'package:algoriza_todo_app/core/util/blocks/app/cubit.dart';
import 'package:algoriza_todo_app/core/util/blocks/app/states.dart';
import 'package:algoriza_todo_app/modules/add_tasks/add_tasks_screen.dart';
import 'package:algoriza_todo_app/modules/all_tasks/all_tasks.dart';
import 'package:algoriza_todo_app/modules/completed_tasks/completed_tasks.dart';
import 'package:algoriza_todo_app/modules/favorite_tasks/favorite_tasks_screen.dart';
import 'package:algoriza_todo_app/modules/schedule/schedule_screen.dart';
import 'package:algoriza_todo_app/modules/uncompleted_tasks/uncompleted_tasks.dart';
import 'package:algoriza_todo_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:todo_app_algoriza/modules/add_tasks/add_tasks_screen.dart';
//import 'package:todo_app_algoriza/modules/all_tasks/all_tasks_screen.dart';
//import 'package:todo_app_algoriza/modules/completed_tasks/complete_tasks_screen.dart';
//import 'package:todo_app_algoriza/modules/uncompleted_tasks/uncomplete_tasks_screen.dart';

class BoardScreen extends StatefulWidget {

  @override
  State<BoardScreen> createState() => _BoardScreenState();

}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
   late TabController tabController;
    return DefaultTabController(
      length: 4,
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var tasks=AppCubit.get(context).tasks;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Board",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed:(){
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => const ScheduleScreen()));
                  },
                  icon: const Icon(Icons.edit_note,
                    color: Colors.black,
                    size: 23.0,),),
                IconButton(
                  onPressed:(){
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => const ScheduleScreen()));
                  },
                  icon: const Icon(Icons.notifications_none,
                    color: Colors.black,
                    size: 20.0,),),
               // SizedBox(width:2),

                IconButton(
                    onPressed:(){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => const ScheduleScreen()));
                    },
                  icon: const Icon(Icons.calendar_month_outlined,
              color: Colors.black,
                  size: 20.0,),),

              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(3.0),
              child: DefaultTabController(
                length: 4,
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Divider(
                      thickness: 1.0,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child:  const TabBar(
                        indicator: BoxDecoration(
                          color: Colors.white,
                        ),
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.black,
                        indicatorWeight: 3,
                        labelStyle: TextStyle(
                          fontWeight:FontWeight.w600
                        ),
                        tabs: [
                          Tab(icon: Text('All',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),),),
                          Tab(icon: Text('Completed',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),),),
                          Tab(icon: Text('UnCompleted',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),),),
                          Tab(icon: Text('Favorites',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),),),

                        ],
                      ),
                    ),
                    const Divider(
                      height: 1.5,
                      color: Colors.grey,
                    ),


                    Expanded(
                      child: TabBarView(
                      //  controller: tabController,
                        children: [
                          const Center(child: AllTasks(),),
                          Center(child: CompletedTasks(),),
                          Center(child: UnCompletedTasks(),),
                          Center(child: FavoriteTasks(),),
                        ],
                      ),
                    ),

                    DefaultButton(text: 'Add New Task',
                        function: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                AddTasksScreen()),);
                        }),
                  ],

                ),
              ),
            ),

          );
        },
      ),

    );
  }
}
