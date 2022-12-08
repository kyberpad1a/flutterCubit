import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_cubit_state.dart';

class ThemeCubitCubit extends Cubit<ThemeData> {
  ThemeCubitCubit() : super(ThemeData.light());
  

  void themeSwitch(){
    if(state == ThemeData.light()){
      emit(ThemeData.dark());
    }
    else{
      emit(ThemeData.light());
    }
}
}