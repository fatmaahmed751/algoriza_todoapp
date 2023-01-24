import 'package:algoriza_todo_app/core/util/blocks/app/cubit.dart';
import 'package:algoriza_todo_app/core/util/blocks/app/states.dart';
import 'package:algoriza_todo_app/shared/components/components.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title:  Text('Schedule',
            style: Theme
            .of(context)
            .textTheme
            .bodyText2!
            .copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        ),
            leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black87,
               size: 20.0,
            ),
              onPressed: () {
                Navigator.pop(context);
              },),
            shape: const Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                )
            ),
          ),
          body: BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
          return Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: DatePicker(
                    DateTime.now(),
                    height: 80,
                    width: 50,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.greenAccent.shade700,
                    selectedTextColor: Colors.white,
                    dateTextStyle: const TextStyle(
                      // fontWeight: FontWeight.w200,
                      fontSize: 10,
                      color: Colors.black87,
                    ),
                    dayTextStyle: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
             SizedBox(
               height: 2.0,
             ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.EEEE().format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 17,
                      ),),
                    const Spacer(),
                    Text(DateFormat.yMMMd().format(DateTime.now())),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated
                 (itemBuilder:(context,index)=> buildScheduleItem(AppCubit.get(context).tasks[index]),
                itemCount: AppCubit.get(context).tasks.length,
                  separatorBuilder:(context,index)=> SizedBox(height: 9.0,

                  ),
        ),
              ),

            ],
          );
  },
),
        );

   
  }
}
