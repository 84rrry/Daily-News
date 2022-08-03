import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Components/Components.dart';
import 'package:newsapp/Cubit/NewsCubits.dart';
import 'package:newsapp/Cubit/States.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var sportsNewsList=NewsCubit.get(context).sportsNews;
        return articleBuilder(sportsNewsList);
      },
    );
  }
}

