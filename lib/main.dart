import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_flutter/controllers/game_bloc.dart';
import 'package:tetris_flutter/views/menu_screen.dart';
import 'package:tetris_flutter/utils/constants.dart';

void main() {
  runApp(const TetrisApp());
}

class TetrisApp extends StatelessWidget {
  const TetrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc()..add(GameStarted()),
      child: MaterialApp(
        title: 'Tetris',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Constants.primaryColor,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const MenuScreen(),
      ),
    );
  }
}
