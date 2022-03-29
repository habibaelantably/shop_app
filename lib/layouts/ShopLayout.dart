
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/models/Favorites_model.dart';
import 'package:shop_app/modules/Search/SearchScreen.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopStates.dart';
import 'package:shop_app/styles/colors.dart';

class shoplayoutScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var cubit=ShopAppcubit.get(context);
    return BlocConsumer<ShopAppcubit,ShopAppStates>(
      builder: (BuildContext context, state) {
        return  Scaffold(
            appBar: AppBar(
              backgroundColor: deafultColor,
              title: Text('Salla',
              style: TextStyle(
                color: Colors.white
              ),
              ),
              actions: [
                IconButton(
                  onPressed: (){NavigateTo(context, SearchScreen());},
                  icon: Icon(Icons.search),
                  color: Colors.white,)
              ],
            ),
            body: cubit.bottomScreens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeNaveState(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'favourites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
            ],
            currentIndex: cubit.currentindex,
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}