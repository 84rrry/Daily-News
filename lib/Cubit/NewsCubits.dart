import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/States.dart';
import 'package:newsapp/Screens/SettingsScreen.dart';
import '../Network/Dio_Helper.dart';
import '../Screens/BusinessScreen.dart';
import '../Screens/ScienceScreen.dart';
import '../Screens/SportsScreen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> newsTypes = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.work),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_basketball,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'science',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),
  ];

  List<Widget> newsScreens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];
  void ChangeBtmNavItem(int index) {
    currentIndex = index;
    if (index == 1) getSportsNews();
    if (index == 2) getScienceNews();
    emit(BottomNavState());
  }

  List<dynamic> businessNews = [];
  void getBusinessNews() {
    if (businessNews.isEmpty) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'business',
          'apiKey': '5bbe1c636fcb40dda9a05aef876bbdaa',
        },
      ).then((value) {
        // print(value.data['articles'][0]['title'].toString());
        businessNews = value.data['articles'];

        emit(NewsGetBusinessSuccesState());
      }).catchError((error) {
        // print(error);
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccesState());
    }
  }

  List<dynamic> sportsNews = [];
  void getSportsNews() {
    if (sportsNews.isEmpty) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': '5bbe1c636fcb40dda9a05aef876bbdaa',
        },
      ).then((value) {
        // print(value.data['articles'][0]['title'].toString());
        sportsNews = value.data['articles'];

        emit(NewsGetSportsSuccesState());
      }).catchError((error) {
        print(error);
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccesState());
    }
  }

  List<dynamic> scienceNews = [];
  void getScienceNews() {
    if (scienceNews.isEmpty) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': '5bbe1c636fcb40dda9a05aef876bbdaa',
        },
      ).then((value) {
        // print(value.data['articles'][0]['title'].toString());
        scienceNews = value.data['articles'];
        // print(scienceNews[0]);
        emit(NewsGetScienceSuccesState());
      }).catchError((error) {
        print(error);
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccesState());
    }
  }

  // https://newsapi.org/
  // v2/everything?
  // q=tesla&apiKey=5bbe1c636fcb40dda9a05aef876bbdaa
  List<dynamic> searchResults = [];
  void getSearchResults(String value) {

    emit(NewsGetSearchLoadingState());
    // searchResults = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '5bbe1c636fcb40dda9a05aef876bbdaa',
      },
    ).then((value) {
      // print(value.data['articles'][0]['title'].toString());
      searchResults = value.data['articles'];
      // print(SearchNews[0]);
      emit(NewsGetSearchSuccesState());
    }).catchError((error) {
      print(error);
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
