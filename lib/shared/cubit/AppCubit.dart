
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/cacheHelper.dart';
import 'package:shop_app/Network/local/endPoint.dart';
import 'package:shop_app/Network/remote/DioHelper.dart';
import 'package:shop_app/models/ShoploginModel.dart';

import 'package:shop_app/shared/cubit/AppStates.dart';



import 'AppStates.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppIntialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool isDark=false;

  void changeAppMode({bool ? fromShared})
  {
    if(fromShared!=null)
    {
      isDark=fromShared;
      emit(AppChangeNewsMode());

    }
    else
    {
      isDark= !isDark;
      cacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeNewsMode());
      });
    }

  }

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password
  })
  {
    emit(AppLoadingstate());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password
        }
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJason(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      print(loginModel!.data!.email);
      emit(AppSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(AppErrorState(error.toString()));
    });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;


  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.visibility_outlined :Icons.visibility_off_outlined;

    emit(AppChangePasswordVisibilityState());
  }




}