import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jungle_jumper/state/main_game_state.dart';
import 'package:jungle_jumper/ui/main_menu_screen.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<MainGameState>(MainGameState());
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainMenuScreen(),
  ));
}
