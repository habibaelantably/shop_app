
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/endPoint.dart';
import 'package:shop_app/Network/remote/DioHelper.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/models/Favorites_model.dart';
import 'package:shop_app/models/ShoploginModel.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/categories_model.dart';
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

  Map<int , bool>? favourites={};

  void getHomeData() {
    emit(ShopAppLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeData = HomeModel.fromJson(value.data);
      // printFullText(homeData!.data!.banners[0].image);
      // print(homeData!.status);
      homeData!.data.products.forEach((element) {
        favourites!.addAll({element.id!:element.inFavourites!});
      });
      print(favourites.toString());
      emit(ShopAppSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorHomeDataState());
    });
  }

  changeFavoritesModel? ChangeFavouritesmodel;

  void changeFavState(int? productId)
  {
    favourites![productId!]=!favourites![productId]!;
    emit(ShopAppChangeFavState());

    DioHelper.postData(
        url: FAVORITES,
        data:
        {
          'product_id':productId
        },
      token: token
    ).then((value)
    {
      ChangeFavouritesmodel=changeFavoritesModel.fromJson(value.data);
      //print(value.data);

      if(!ChangeFavouritesmodel!.status!)
      {
        favourites![productId]=!favourites![productId]!;
      }else
        {
          getFavoritesData();
        }

      emit(ShopAppSuccessChangeFavState(ChangeFavouritesmodel!));
    }).catchError((error)
    {
      favourites![productId]=!favourites![productId]!;
      emit(ShopAppErrorChangeFavState());
    });
  }
  CategoriesModel? categoriesData;

  void getCategoriesData() {

    DioHelper.getData(
      url: Categories,
      token: token,
    ).then((value) {
      categoriesData = CategoriesModel.fromJson(value.data);
      // printFullText(homeData!.data!.banners[0].image);
      // print(homeData!.status);
      emit(ShopAppSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorCategoriesDataState());
    });
  }

   Favorites_Model? favoritesModel;

  void getFavoritesData() {

    emit(ShopAppLoadingFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = Favorites_Model.fromJson(value.data);
      print(value.data);
      //print('favorites model is>>>>'+favoritesModel.toString());
      // printFullText(homeData!.data!.banners[0].image);
      // print(homeData!.status);
      emit(ShopAppSuccessGetFavState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorGetFavState());
    });
  }

  ShopLoginModel? userData;

  void getUserData() {

    emit(ShopAppLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = ShopLoginModel.fromJason(value.data);
      // printFullText(homeData!.data!.banners[0].image);
      // print(homeData!.status);
      emit(ShopAppSuccessGetUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorGetUserDataState());
    });
  }

  void Update({
  required String name,
  required String email,
  required String phone,
}) {

    emit(ShopAppLoadingUpdateDataState());

    DioHelper.putData(
      url: UPDATE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone
      },
    ).then((value) {
      userData = ShopLoginModel.fromJason(value.data);
      // printFullText(homeData!.data!.banners[0].image);
      // print(homeData!.status);
      emit(ShopAppSuccessUpdateDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorUpdateDataState());
    });
  }
}