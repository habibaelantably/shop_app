
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopStates.dart';

class prouductsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<ShopAppcubit,ShopAppStates>(
     listener: (BuildContext context, state) {  },
     builder: (BuildContext context, Object? state)
     {
        return BuildCondition(
          condition: ShopAppcubit.get(context).homeData != null,
          builder: (context)=>HomeBuilder(),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
     },

   );
  }

}

Widget HomeBuilder ()=>Column(
  children: [

  ],
);