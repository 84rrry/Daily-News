
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Components/Components.dart';
import 'package:newsapp/Cubit/NewsCubits.dart';
import 'package:newsapp/Cubit/States.dart';
import 'package:newsapp/Cubit/Theme/theme_cubit.dart';
import 'package:newsapp/Screens/SearchScreen.dart';

import '../Components/FlippingSwitch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    late String page;
  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
     
      },
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
        
          appBar: AppBar(
            title: Container(
              margin: EdgeInsets.only(left: 10.0),
              padding: const EdgeInsets.only(left: 0.0),
              child: Text('News App'),
            ),
            actions: [
              IconButton(
                onPressed: () {
                NavigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Center(
                         child: FlippingSwitch(
                width: 50,
                height: 20,
                color: Colors.white,
                background: Colors.black,
               leftLabel: Icons.brightness_3,
               rightLabel: Icons.brightness_4,
                onChanged: (bool isLeftActive){
                  setState(() {
                         page= isLeftActive ? 'Left':'Right';
                         context.read<ThemeCubit>().changeAppThemeMode();
                  });

                
                },
      ),
                       ),
                     ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 2,
                    offset: Offset(0, 1))
              ],
            ),
            child: BottomNavigationBar(
              items: cubit.newsTypes,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
             
                cubit.ChangeBtmNavItem(index);
            
              },
            ),
          ),
          body: cubit.newsScreens[cubit.currentIndex],
        );
      },
    );
  }
}
