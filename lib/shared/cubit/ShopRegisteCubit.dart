
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/endPoint.dart';
import 'package:shop_app/Network/remote/DioHelper.dart';
import 'package:shop_app/models/ShoploginModel.dart';
import 'package:shop_app/shared/cubit/ShopRegisterStates.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterAppStates>
{
  ShopRegisterCubit() : super(ShopAppIntialRegisterState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  bool isDark=false;

  ShopLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone
  })
  {
    emit(ShopAppLoadingRegisterstate());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone
        }
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJason(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      print(loginModel!.data!.email);
      emit(ShopAppSuccessRegisterState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorRegisterState(error.toString()));
    });
  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;


  void changePasswordVisibilityRegister()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.visibility_outlined :Icons.visibility_off_outlined;

    emit(ShopAppChangePasswordVisibilityRegisterState());
  }

}