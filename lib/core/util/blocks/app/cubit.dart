import 'package:algoriza_todo_app/core/models/build_task_model.dart';
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
  int favorites=0;
  int completed=1;

  final GlobalKey<FormState> formKey=GlobalKey();


 // DateTime selectedDate = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();



 int currentSelectedRemind =0;

  List<BuildTaskModel> tasks = [];
  List<BuildTaskModel>completeTasks=[];
  List<Map>newTasks=[];
  List<BuildTaskModel>favoriteTasks=[];

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
          await database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,startTime TEXT,endTime TEXT,remind TEXT,repeat TEXT,color INTEGER ,completed INTEGER,favorites INTEGER )'
          ).then((value) {
            print('table created');

          //  emit(AppDatabaseTableCreated());
          })
              .catchError((error) {
            print('${error.toString()}');
          });
        },
        onOpen: (Database db) {
          database = db;
         getTasksData();
          print(tasks);
          print('open');
        },
   /* ).then((value) {
          database=value;
    }*/
    );
  }

  void insertTodoAppDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String reminder,
    required String repeat,
    required int color,
   // required int completed,
  // required int favorites,
  }) {
    database.transaction((txn) async {
  await txn.rawInsert('INSERT INTO tasks (title,date,startTime,endTime,remind,repeat,color,completed,favorites)VALUES ("${titleController.text}","${dateController.text}","${startTimeController.text}","${endTimeController.text}","${remindController.text}","${repeatController.text}","$taskColor",0,0)')
          .then((value) {
        debugPrint('Data inserted');
        print(tasks.toString());
        print(startTimeController.text);
        getTasksData();
       //emit(AppDatabaseInserted());
      }).catchError((error) {
        debugPrint(error.toString());
      });
    });
  }

void getTasksData() async {
  //emit(AppDatabaseInserted());
    tasks=[];
    //completeTasks=[];
   // favoriteTasks=[];
  database.rawQuery('SELECT * FROM tasks').
  then((value) {
    print('gettasks');
      for (var element in value) {
        tasks.add(BuildTaskModel.fromJson(element));
      }
      emit(AppGetDatabase());
    });
}

void upDateCompleted(
   int taskId,
)async{
 // getTasksData();
  int completed=tasks.firstWhere((element) => element.id==taskId).completed==1?0:1;
await database.rawUpdate(
  'UPDATE tasks SET completed =? WHERE id=$taskId',[completed]
    ).then((value)
{
  getTasksData();
  print(tasks);
  //emit(AppUpdateCompleted());
}).catchError((error){
  print(error.toString());
});
  }

  void upDateFavorite(
      int taskId,
      )async{
    int favorites=tasks.firstWhere((element) => element.id==taskId).favorites==1?0:1;
    await database.rawUpdate(
        'UPDATE tasks SET favorites =? WHERE id=$taskId',[favorites]
    ).then((value)
    {
       getTasksData();
      print(tasks);
      //emit(AppUpdateFavorite());
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
                emit(TaskColorChanged());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: index == 0 ? Colors.yellow[600] :
                  index == 1 ? Colors.orange[300]: index == 2 ?
                  Colors.blue[400] : Colors.deepOrange,
                  child: taskColor==index? const Icon(Icons.done,
                    color: Colors.white,
                    size: 16,):Container(),


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