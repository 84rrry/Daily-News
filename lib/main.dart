import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/NewsCubits.dart';
import 'package:newsapp/Cubit/Theme/theme_cubit.dart';
import 'package:newsapp/Layout/HomeScreen.dart';
import 'package:newsapp/Network/Dio_Helper.dart';
import 'package:newsapp/Themes/Apptheme.dart';
import 'Cubit/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();

      runApp(NewsApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class NewsApp extends StatelessWidget {

  NewsApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusinessNews()),
        BlocProvider(create: (context)=> ThemeCubit()),
      ],
      child:  Builder(
        builder: (context) {
          return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: LightAppTheme(),
                darkTheme: DarkAppTheme(),
                themeMode: context.select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
                home: HomeScreen(),
              );
        }
      ));
        }
     
  }

