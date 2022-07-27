import 'package:algoriza_todo_app/core/util/blocks/app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() :super (AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  int taskColor=0;
  bool favorite=false;
  bool status=false;


 // DateTime selectedDate = DateTime.now();

  //String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

 // int selectedColor = 0;

 // String endTime = "10:08";

  int selectedRemind = 5;
 /* List<int>remindList =
  [
    5,
    10,
    15,
    20,
  ];*/

 // String selectedRepeat = "None";
/*  List<String>repeatList = [
    "None",
    "Daily",
    "weekly",
    "Monthly",
  ];*/

 int currentSelectedRemind = 5;

  List<Map> tasks = [];
  List<Map>completeTasks=[];
  List<Map>newTasks=[];
  List<Map>favoriteTasks=[];


  void createDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');

    databaseOpened(
      path: path,
    );
    print('database created');
    emit(AppDatabaseCreated());
  }


  void databaseOpened({
    required String path,
  }) async {
    await openDatabase(
        path,
        version: 1,
        onCreate: (database, version) async
        {
          await database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,startTime TEXT,endTime TEXT,remind INTEGER,repeat TEXT,color INTEGER ,status TEXT,favorite TEXT )'
          ).then((value) {
            print('table created');

            emit(AppDatabaseTableCreated());
          })
              .catchError((error) {
            print('${error.toString()}');
          });
        },
        onOpen: (Database db) {
          database = db;
        // getTasksData();
          print(tasks);
          print('open');
        },).then((value) {
          database=value;
    });
  }

  void insertTodoAppDatabase(
  //required String title,
  ) {
    database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO tasks (title,date,startTime,endTime,remind,repeat,color,status,favorite)VALUES ("${titleController.text}","${dateController.text}","${startTimeController.text}","${endTimeController.text}","${remindController.text}","${repeatController.text}","$taskColor","new","${favorite.toString()}")')
          .then((value) {
        debugPrint('Data inserted');
        getTasksData();
        emit(AppDatabaseInserted());
      }).catchError((error) {
        debugPrint(error.toString());
      });
    });
  }

void getTasksData() async {

    newTasks=[];
    completeTasks=[];
    favoriteTasks=[];
  database.rawQuery('SELECT * FROM tasks').
  then((value) {
    print('gettasks');
    tasks = value;
    print(tasks);
  tasks.forEach((element) {
     if(element['status']=='new')
      newTasks.add(element);
      else if(element['status']=='Completed')
       completeTasks.add(element);
     else favoriteTasks.add(element);

  });
  print(completeTasks.length);
  }

  );
    emit(AppGetDatabase());

}

void upDateFavorite({
  required bool favorite,
  required int id,
})async{
await database.rawUpdate(
  'UPDATE tasks SET favorite =? WHERE id=?',
    ['${favorite.toString()}',id],
    ).then((value)
{
  getTasksData();
  print(tasks);
  emit(AppUpdateFavorite());
}).catchError((error){
  print(error.toString());
});
  }

  void upDateStatusData({
    required bool status,
    required int id,
  })async{
    await database.rawUpdate(
      'UPDATE tasks SET status =? WHERE id=?',
      ['${status.toString()}',id],
    ).then((value)
    {
      getTasksData();
      print(tasks);
      emit(AppUpdateDatabaseState());
    }).catchError((error){
      print(error.toString());
    });
  }




  colorPicked() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Color",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0,),

        Wrap(
          children: List<Widget>.generate(
              4, (int index) {
            return GestureDetector( //error
              onTap: () {
                taskColor = index;
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: index == 0 ? Colors.yellow :
                  index == 1 ? Colors.red : index == 2 ?
                  Colors.blueAccent : Colors.deepOrange,
                  child: taskColor == index ? const Icon(Icons.done,
                    color: Colors.white,
                    size: 16,) : Container(),

                ),
              ),
            );
          }
          ),
        ),
      ],
    );
  }
}