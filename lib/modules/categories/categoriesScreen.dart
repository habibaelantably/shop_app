

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopStates.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit,ShopAppStates>(
        builder: (context,state){
          return  ListView.separated(
         itemBuilder:(context,index)=>buildCatItem(ShopAppcubit.get(context).categoriesData!.data!.data[index]),
       separatorBuilder:(context,index)=>myDivider(),
         itemCount:ShopAppcubit.get(context).categoriesData!.data!.data.length,
     );
        },
        listener: (context,state)
        {

        }
        );
  }
}
Widget buildCatItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: [
      Image(
        image: NetworkImage(model.image),
        height: 80.0,
        width: 80.0,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 20.0,),
      Text(model.name,
        style: TextStyle(
            fontSize: 20.0
        ),
      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios)
    ],
  ),
);