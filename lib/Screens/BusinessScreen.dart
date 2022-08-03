import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Components/Components.dart';
import 'package:newsapp/Cubit/NewsCubits.dart';
import 'package:newsapp/Cubit/States.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var businessNewsList=NewsCubit.get(context).businessNews;
        return articleBuilder(businessNewsList);
      },
    );
  }
}
