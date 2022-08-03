import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Components/Components.dart';
import 'package:newsapp/Cubit/NewsCubits.dart';
import 'package:newsapp/Cubit/States.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color primaryColor= Theme.of(context).primaryColor;
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return  Scaffold(
        appBar: AppBar(
                //  centerTitle: true,
          title:    Container(
            padding: EdgeInsets.only(left: 10),
            child: DefaultFormField(
              style: TextStyle(color: primaryColor),
              hintColor: primaryColor,
                bordercolor: Colors.black,
                controller: searchController,
                hint: "Enter search keywords",
                onChanged: (value){
                  NewsCubit.get(context).getSearchResults(value);
                }
                
              ),
           
          )),
        body: Container(
          // padding: EdgeInsets.symmetric(horizontal: 20,),
          child: Column(children: [
            Expanded(child: articleBuilder(NewsCubit.get(context).searchResults,isSearch: true,itemCount:NewsCubit.get(context).searchResults.length )),
          ]),
        ),
      );
      },

    );
  }
}
