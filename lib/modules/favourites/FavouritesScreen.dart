

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:shop_app/models/Favorites_model.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopStates.dart';
import 'package:shop_app/styles/colors.dart';

class FavouritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopAppcubit,ShopAppStates>(
      builder: (BuildContext context, state)
      {
        return BuildCondition(
          condition: state is! ShopAppLoadingFavoritesState ,
          builder: (context)=>ListView.separated(
            itemBuilder: (context,index)=>buildFavItem(ShopAppcubit.get(context).favoritesModel!.data!.data[index],context),
            separatorBuilder: (context,index)=>SizedBox(height: 0.0,),
            itemCount:ShopAppcubit.get(context).favoritesModel!.data!.data.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },//ShopAppcubit.get(context).favoritesModel!.data!.favData![index]
      //mBuilder: (context, index) => buildListItem(
      //                         ShopCubit.get(context)
      //                             .favoritesModel!
      //                             .data
      //                             .data[index]
      //                             .product,

      listener: (BuildContext context, Object? state)
      {

      },
    );
  }
}

Widget buildFavItem(model,context)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),
      color: Colors.grey[100],
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 2.0,
          // spreadRadius: 0.0,
          offset: Offset(1.0, 1.0), // shadow direction: bottom right
        )
      ],
    ),
    height: 320,

    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(
                  '${model.product!.image}'
                ),
                height: 220,
                width: double.infinity,
                //fit: BoxFit.cover,
              ),
            ),
            if( model.product!.discount!=0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.product!.name.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                   '${model.product!.price}',
                    style: TextStyle(
                      color: deafultColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4.0,),
                  if( model.product!.discount != 0)
                    Text(
                      '${model.product!.oldPrice}',
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopAppcubit.get(context).changeFavState(model.product!.id);
                      },
                       icon:ShopAppcubit.get(context).favourites![model.product.id]! ? Icon(Icons.favorite,color: deafultColor,)
                          :Icon(Icons.favorite_border)
                  )
                ],
              ),
            ],
          ),
        )

      ],
    ),
  ),
);