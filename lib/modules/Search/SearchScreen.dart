

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopSearchCubit.dart';
import 'package:shop_app/shared/cubit/ShopSearchStates.dart';
import 'package:shop_app/styles/colors.dart';

class SearchScreen extends StatelessWidget
{
  var formKey=GlobalKey<FormState>();
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,ShopSearchStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state)
        {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      deafultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validator: (value)
                          {
                            if(value!.isEmpty){
                              return 'please enter your search word';
                            }
                            return null;
                          },
                          Onsubmite: (String? text){
                            SearchCubit.get(context).getSearchItems(text);
                          },
                          prefix: Icons.search,
                          hint: 'search'
                      ),
                      if(state is LoadingShopSearchState)
                        LinearProgressIndicator(),
                      if(state is SuccessShopSearchState)
                        SingleChildScrollView(
                          child: ListView.separated(
                              itemBuilder: (context,index)=>buildSearchItem(
                                  SearchCubit.get(context).searchModel.data.searchProduct[index],
                                  context,isOldPrice: false),
                              separatorBuilder: (context,index)=>myDivider(),
                              itemCount: SearchCubit.get(context).searchModel.data.searchProduct.length),
                        )
                    ],
                  ),
                ),
              )
          );
        },

      ),
    );
  }

}

Widget buildSearchItem( Product model,context,{bool isOldPrice=true})=>Row(
  children: [
    Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: NetworkImage(model.image),
            height: 200,
          ),
         ),
        if(model.discount !=0 && isOldPrice)
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
    SizedBox(width: 10.0,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${model.name}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            // Text('${model.Price.round()}L.E',
            //   style: TextStyle(
            //     color: deafultColor,
            //     fontSize: 14,
            //   ),
            // ),
            //SizedBox(width: 4.0,),
            if(model.discount !=0 )
              Text('${model.oldPrice.round()}',
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            Spacer(),
            IconButton(
                onPressed: (){
                  ShopAppcubit.get(context).changeFavState(model.id);
                },
                icon:ShopAppcubit.get(context).favourites![model.id]! ? Icon(Icons.favorite,color: deafultColor,)
                    :Icon(Icons.favorite_border)
            )
          ],
        )
      ],
    )
  ],
);