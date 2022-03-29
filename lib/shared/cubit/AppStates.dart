
import 'package:shop_app/models/ShoploginModel.dart';
 class AppStates {}

class AppIntialState extends AppStates{}

class AppBotomnavState extends AppStates{}

class AppLoadingstate extends AppStates{}


class AppSuccessState extends AppStates
{
  final ShopLoginModel loginModel;

  AppSuccessState(this.loginModel);
}


class AppChangeNewsMode extends AppStates{}

class AppErrorState extends AppStates {
  final String error;

  AppErrorState(this.error);
}

class AppChangePasswordVisibilityState extends AppStates{}





