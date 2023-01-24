import 'package:algoriza_todo_app/core/util/blocks/app/cubit.dart';
import 'package:algoriza_todo_app/modules/onboard_screen/board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared/styles/themes/text_theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (context) => AppCubit()
      ..createDatabase(),//..getTasksData(),
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme,
    home: BoardScreen(),

    ),
    );
  }
}
