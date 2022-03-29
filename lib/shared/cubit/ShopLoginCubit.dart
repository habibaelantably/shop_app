
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/endPoint.dart';
import 'package:shop_app/Network/remote/DioHelper.dart';
import 'package:shop_app/models/ShoploginModel.dart';
import 'package:shop_app/shared/cubit/ShopLoginStates.dart';

class ShopAppLoginCubit extends Cubit<ShopAppLoginStates>
{
  ShopAppLoginCubit() : super(ShopApploginIntialState());

  static ShopAppLoginCubit get(context)=>BlocProvider.of(context);


  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password
  })
  {
    emit(ShopAppLoginLoadingState());
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
      emit(ShopAppLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopAppLoginErrorState(error.toString()));
    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;


  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.visibility_outlined :Icons.visibility_off_outlined;

    emit(ShopAppChangePasswordVisibilityStateLogin());
  }

}