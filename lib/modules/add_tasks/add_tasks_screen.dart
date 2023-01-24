import 'package:algoriza_todo_app/core/util/blocks/app/cubit.dart';
import 'package:algoriza_todo_app/core/util/blocks/app/states.dart';
import 'package:algoriza_todo_app/modules/schedule/schedule_screen.dart';
import 'package:algoriza_todo_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTasksScreen extends StatelessWidget {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  var taskTitle = TextInputType.text;
  String taskColor = '';
  int selectedColor = 0;
  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  String endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int currentSelectedRemind = 0;
  List<String>repeatList = [
    "None",
    "Daily",
    "weekly",
    "Monthly",
  ];
  List<ReminderModel>remindList =
  [
    ReminderModel(reminder:'5 minutes early' , minutes: 5),
    ReminderModel(reminder: '10 minutes early', minutes: 10),
    ReminderModel(reminder: '15 minutes early', minutes: 15),
    ReminderModel(reminder:'1 hours early', minutes: 1),
  ];

  AddTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
     //
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 60.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black87,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },),
            title: Text("Add task",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultLine(),
                    const SizedBox(height: 10.0,),
                    subTitle(text: 'Title'),
                    const SizedBox(height: 10.0,),
                    defaultFormField(
                        controller: cubit.titleController,
                        hint: 'Task Title',
                        radius: BorderRadius.circular(10.0)),
                    const SizedBox(height: 10.0,),
                    subTitle(text: 'Data'),
                    const SizedBox(height: 10.0,),
                    defaultFormField(
                      type: TextInputType.datetime,
                      hint: 'Task Date',
                      controller: cubit.dateController,
                      icon: IconButton(icon: (const Icon(Icons
                          .calendar_month_sharp,
                        color: Colors.grey,
                      )),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2023-07-15'),
                          ).then((value) {
                            cubit.dateController.text =
                                DateFormat.yMd().format(value!);
                          });
                        },

                      ),
                      radius: BorderRadius.circular(10.0),
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              subTitle(text: 'Start Time'),
                              const SizedBox(height: 10.0,),

                              defaultFormField(
                                hint: 'Start Time',
                                controller: startTimeController,
                                radius: BorderRadius.circular(7.0),
                                type: TextInputType.datetime,
                                icon: IconButton(
                                  icon: (const Icon(Icons.watch_later_outlined,
                                    size: 20.0,
                                    color: Colors.grey,
                                  )),
                                  onPressed: () async {
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {

                          startTimeController.text=value!.
                                   format(context);
                                    });
                                  },
                                ),),

                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        Expanded(
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                subTitle(text: 'End Time'),
                                const SizedBox(height: 10.0,),
                                defaultFormField(
                                  hint: 'End Time',
                                  controller: endTimeController,
                                  type: TextInputType.datetime,

                                  icon: IconButton(
                                    icon: (const Icon(Icons.watch_later_outlined,
                                      size: 20.0,)),
                                    onPressed: () async {
                                       await showTimePicker(
                                           context: context,
                                           initialTime: TimeOfDay.now(),
                                       ).then((value) {

                                         endTimeController.text =value!.format(context);
                                              /* DateFormat('hh:mm a').format(
                                                   DateTime.now());*/
                                       });
                                    },
                                  ),
                                  function:(String? value){
                                    if(value?.isEmpty??true){
                                      return 'time error';
                                    }else{
                                      return null;
                                    }
                                  },
                                  radius: BorderRadius.circular(7.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    subTitle(text: 'Remind'),
                    const SizedBox(height: 10.0,),
                    defaultFormField(
                      hint: '5 minutes early',
                      controller:cubit.remindController,
                      radius: BorderRadius.circular(10.0),
                      suffixWidget: DropdownButton(
                      //  value: cubit.remindController,
                        isDense: true,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined,
                          size: 26,
                          color: Colors.black,
                        ),
                        iconSize: 30,
                        elevation: 4,
                       underline: Container(height: 0,),
                        items: remindList.asMap().map((
                        key,value)=>MapEntry(
                          key,
                        DropdownMenuItem(
                              value:  value.minutes,
                              child:Text( value.reminder.toString()),
                        ),
                        ),
                        ).values.toList(),
                        onChanged: (value) {
                    //currentSelectedRemind=int.parse(value.toString());
                   cubit.remindController.text= value.toString();
                          //currentSelectedRemind=int.parse(value.toString());
                       //  cubit.currentSelectedRemind=int.parse(value.toString());
                          print(value);
                          //remindController.text= !;
                        },
                      ),
                    ),

                    const SizedBox(height: 10.0,),
                    subTitle(text: 'Repeat'),
                    const SizedBox(height: 10.0,),
                    defaultFormField(
                      hint: 'Daily ',
                      controller: cubit.repeatController,
                      radius: BorderRadius.circular(10.0),
                      suffixWidget: DropdownButton(
                        //value: selectedRemind,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined,
                          size: 30,
                          color: Colors.grey,),

                        items: repeatList.map<DropdownMenuItem<String>>((
                            String? value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value!,
                                style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          cubit.repeatController.text = newValue!;
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      children: [
                        cubit.colorPicked(),
                      ],
                    ),

                    DefaultButton(text: 'Create a Task',
                  function: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => const ScheduleScreen()));
                          cubit.insertTodoAppDatabase(
                            title:cubit.titleController.text,
                            date: cubit.dateController.text,
                            startTime:cubit.startTimeController.text ,
                            reminder:currentSelectedRemind.toString(),
                            endTime:cubit.endTimeController.text,
                            repeat: cubit.repeatController.text,
                            //completed:cubit.completed,
                            color:cubit.taskColor,
                          //  favorites: cubit.favorites,
                          );

                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

/*getTime({required bool isStartTime,context}) async {
    var newTime = await _showTimePicker(context);
    String _formatedTime = newTime.format(context);
    if (newTime == null)
      return;
    else if (isStartTime == true) {
          startTime = _formatedTime;
    } else if (isStartTime == false) {
          startTime = _formatedTime;
    }
  }*/
/*
   Future showTimePicker()async {
    return  await showTimePicker(
      context:context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(hour: int.parse(startTime.split(":")[0]),
        minute: int.parse(startTime.split(":")[1].split(" ")[0]),),
    ).then((value){

    });
  }*/
/*
  colorPicked() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
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
                selectedColor = index;
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: index == 0 ? Colors.yellow :
                  index == 1 ? Colors.red : index == 2 ?
                  Colors.blueAccent : Colors.deepOrange,
                  child: selectedColor == index ? Icon(Icons.done,
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

*/
}
