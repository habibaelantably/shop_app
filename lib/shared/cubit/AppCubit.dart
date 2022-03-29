
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/cacheHelper.dart';
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


}