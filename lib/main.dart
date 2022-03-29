import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/cacheHelper.dart';
import 'package:shop_app/Network/remote/DioHelper.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/layouts/ShopLayout.dart';
import 'package:shop_app/modules/OnBoarding/OnBoardingScreen.dart';
import 'package:shop_app/shared/cubit/AppCubit.dart';
import 'package:shop_app/shared/cubit/AppStates.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/styles/thems.dart';

import 'bloc_observer.dart';
import 'modules/login/loginScreen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await cacheHelper.init();

  Widget? widget;

  bool ? isDark = cacheHelper.getData(key: 'isDark');

  bool ? onBoarding = cacheHelper.getData(key: 'OnBoarding');

  token = cacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding != null)
  {
    if(token != null)
      widget=shoplayoutScreen();
      else widget=LoginScreen();
  }else
    {
      widget=OnBoardingScreen();
    }

 // print(onBoarding);

  runApp(MyApp(isDark,widget));
}

class MyApp extends StatelessWidget {

  final bool ? isDark;
  final Widget startwidget;

  MyApp(this.isDark,this.startwidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( BuildContext context)=> AppCubit()..changeAppMode(fromShared:isDark,)),
        BlocProvider(create: (context)=>ShopAppcubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData())
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (BuildContext context, state) {
         return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,

            /*AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light*/
            home:startwidget,
            //,
           //onBoarding !=null ? LoginScreen(): OnBoardingScreen(),
          );
        },
        listener: (BuildContext context, Object? state) {  },

      ),
    );
  }
}


