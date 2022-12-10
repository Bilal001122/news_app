import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/science_screen/science_screen.dart';
import 'package:news_app/modules/settings_screen/settings_screen.dart';
import 'package:news_app/modules/sports_screen/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';

import '../../modules/business_screen/business_screen.dart';
import '../network/remote/dio.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  void changeBetweenBottomNavBarItems(int index) {
    currentIndex = index;
    if (currentIndex == 1) getSports();
    if (currentIndex == 2) getScience();
    emit(AppBottomNavState());
  }

  void getBusiness() {
    emit(AppGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'fr',
      'category': 'business',
      'apiKey': '4e1225c5fdd8413a88422e613a3c4d82',
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(AppGetBusinessSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(AppGetBusinessOnErrorState(onError.toString()));
    });
  }

  void getSports() {
    emit(AppGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'fr',
        'category': 'sports',
        'apiKey': '4e1225c5fdd8413a88422e613a3c4d82',
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(AppGetSportsSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(AppGetSportsOnErrorState(onError.toString()));
      });
    } else {
      emit(
        AppGetSportsSuccessState(),
      );
    }
  }

  void getScience() {
    emit(AppGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'fr',
        'category': 'science',
        'apiKey': '4e1225c5fdd8413a88422e613a3c4d82',
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(AppGetScienceSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(AppGetScienceOnErrorState(onError.toString()));
      });
    } else {
      emit(AppGetScienceSuccessState());
    }
  }
}