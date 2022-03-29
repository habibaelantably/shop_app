
import 'package:shop_app/models/ShoploginModel.dart';

 class ShopRegisterAppStates {}

class ShopAppIntialRegisterState extends ShopRegisterAppStates {}

class ShopAppLoadingRegisterstate extends ShopRegisterAppStates {}

class ShopAppSuccessRegisterState extends ShopRegisterAppStates
{
  final ShopLoginModel loginModel;

  ShopAppSuccessRegisterState(this.loginModel);
}

class ShopAppChangePasswordVisibilityRegisterState extends ShopRegisterAppStates {}

class ShopAppErrorRegisterState extends ShopRegisterAppStates {
  final String error;

  ShopAppErrorRegisterState(this.error);
}




