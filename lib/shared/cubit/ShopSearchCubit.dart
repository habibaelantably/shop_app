
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/endPoint.dart';
import 'package:shop_app/Network/remote/DioHelper.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/cubit/ShopSearchStates.dart';

class SearchCubit extends Cubit<ShopSearchStates>
{
  SearchCubit() : super(IntialShopSearchState());

  static SearchCubit get(context)=>BlocProvider.of(context);


  late SearchModel searchModel;

  void getSearchItems(String? text)
  {
    emit(LoadingShopSearchState());

    DioHelper.postData(
        url:SEARCH ,
        data: {
          'text':text
        },
      token: token,
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SuccessShopSearchState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorShopSearchState());
    });
  }

}