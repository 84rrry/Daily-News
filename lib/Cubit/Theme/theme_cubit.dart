import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.dark));

void changeAppThemeMode(){
state.themeMode==ThemeMode.dark ? _setTheme(ThemeMode.light):_setTheme(ThemeMode.dark);
}
void _setTheme(ThemeMode themeMode){
  emit(ThemeState(themeMode: themeMode));
}
}
