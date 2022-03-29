
import 'package:shop_app/models/change_favorites_model.dart';

 class ShopAppStates {}

class ShopAppIntialState extends ShopAppStates{}

class ShopAppBotomnavState extends ShopAppStates{}

class ShopAppLoadingstate extends ShopAppStates{}

class ChangeBottomNavState extends ShopAppStates{}

class ShopAppLoadingHomeDataState extends ShopAppStates{}

class ShopAppSuccessHomeDataState extends ShopAppStates{}

class ShopAppErrorHomeDataState extends ShopAppStates{}

class ShopAppLoadingCategoriesDataState extends ShopAppStates{}

class ShopAppSuccessCategoriesDataState extends ShopAppStates{}

class ShopAppErrorCategoriesDataState extends ShopAppStates{}

class ShopAppSuccessChangeFavState extends ShopAppStates
{
   final changeFavoritesModel? model;

  ShopAppSuccessChangeFavState(this.model);
}

class ShopAppChangeFavState extends ShopAppStates{}

class ShopAppErrorChangeFavState extends ShopAppStates{}

class ShopAppSuccessGetFavState extends ShopAppStates{}

class ShopAppErrorGetFavState extends ShopAppStates{}

class ShopAppLoadingFavoritesState extends ShopAppStates{}

class ShopAppSuccessGetUserDataState extends ShopAppStates{}

class ShopAppErrorGetUserDataState extends ShopAppStates{}

class ShopAppLoadingUserDataState extends ShopAppStates{}

class ShopAppSuccessUpdateDataState extends ShopAppStates{}

class ShopAppErrorUpdateDataState extends ShopAppStates{}

class ShopAppLoadingUpdateDataState extends ShopAppStates{}






