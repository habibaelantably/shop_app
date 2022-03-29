
import 'package:shop_app/models/ShoploginModel.dart';

 class ShopAppLoginStates{}

class ShopApploginIntialState extends ShopAppLoginStates{}

class ShopAppLoginLoadingState extends ShopAppLoginStates{}


class ShopAppLoginSuccessState extends ShopAppLoginStates
{
  final ShopLoginModel loginModel;

  ShopAppLoginSuccessState(this.loginModel);
}

class ShopAppLoginErrorState extends ShopAppLoginStates{
  final String error;

  ShopAppLoginErrorState(this.error);
}

class ShopAppChangePasswordVisibilityStateLogin extends ShopAppLoginStates{}





