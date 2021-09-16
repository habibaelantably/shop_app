
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/endPoint.dart';
import 'package:shop_app/Network/remote/DioHelper.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/Products/ProductsScreen.dart';
import 'package:shop_app/modules/categories/categoriesScreen.dart';
import 'package:shop_app/modules/favourites/FavouritesScreen.dart';
import 'package:shop_app/modules/settings/SettingsScreen.dart';

import 'package:shop_app/shared/cubit/ShopStates.dart';

class ShopAppcubit extends Cubit<ShopAppStates>
{
  ShopAppcubit() : super(ShopAppIntialState());

  static ShopAppcubit get(context) => BlocProvider.of(context);


  int currentindex=0;

  List<Widget> bottomScreens=
  [
    prouductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];

  void changeNaveState(int index)
  {
    currentindex=index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeData;

  void getHomeData()
  {
    emit(ShopAppLoadingHomeDataState());

    DioHelper.getData(
        url:HOME,
        token: token,
    ).then((value)
    {
      homeData=HomeModel.fromJson(value.data);
      printFullText(homeData!.data!.banners[0].image);
      print(homeData!.status);
      emit(ShopAppSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopAppErrorHomeDataState());
    });
  }

}