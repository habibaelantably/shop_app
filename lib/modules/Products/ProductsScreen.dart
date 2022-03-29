

import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopStates.dart';
import 'package:shop_app/styles/colors.dart';

class prouductsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<ShopAppcubit,ShopAppStates>(
     listener: (BuildContext context, state)
     {

       //changeFavoritesModel? model;
       if (state is ShopAppSuccessChangeFavState )
       {
         if(!state.model!.status!)
         {
           showToast(text: state.model!.message!, states: ToastStates.ERROR);
         }
       }
     },
     builder: (BuildContext context, Object? state)
     {
        return BuildCondition(
          condition:ShopAppcubit.get(context).homeData !=null && ShopAppcubit.get(context).categoriesData!=null, //state is! ShopAppLoadingHomeDataState && state is! ShopAppErrorHomeDataState
         // &&  state is! ShopAppLoadingCategoriesDataState &&  state is! ShopAppErrorCategoriesDataState,
          builder: (context)=>ProductsBuilder(ShopAppcubit.get(context).homeData!, ShopAppcubit.get(context).categoriesData!,context ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
     },

   );
  }

}

Widget ProductsBuilder (HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
          items: model.data.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          )).toList(),

          options: CarouselOptions(

            height: 250.0,

            initialPage: 0,

            viewportFraction: 1.0,

            enableInfiniteScroll: true,

            reverse: false,

            autoPlay: true,

            autoPlayAnimationDuration: Duration(seconds: 1),

              autoPlayInterval: Duration(seconds: 3),

            autoPlayCurve: Curves.fastOutSlowIn,

            scrollDirection: Axis.horizontal

          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('Categories',
          style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              color:deafultColor
          ),
        ),
      ),
      Container(
        height: 170,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
            itemBuilder: (context,index)=>buildCategoriesItem(categoriesModel.data!.data[index]),
            separatorBuilder:(context,index)=>SizedBox(width: 10.0,),
            itemCount: categoriesModel.data!.data.length),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('New Products',
          style:TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              color:deafultColor
          ) ,
        ),
      ),
      Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
           childAspectRatio: 1/1.67,
           shrinkWrap: true,
           mainAxisSpacing: 6.0,
           crossAxisSpacing: 6.0,
           physics: NeverScrollableScrollPhysics(),
           children:List.generate(
             model.data.products.length,
             (index)=>buildGridViewItem(model.data.products[index],context)
           )
          ),
        ),
      )
    ],
  ),
);

Widget buildGridViewItem(model,context)=>Container(
  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),
    color: Colors.white,
  ),
  child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: NetworkImage(model.image!),
              height: 200,
            ),
          ),
          if(model.discount !=0)
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
              Text('${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
      ),
              Row(
              children: [
                Text('${model.Price.round()}L.E',
                style: TextStyle(
                  color: deafultColor,
                  fontSize: 14,
                ),
                ),
                SizedBox(width: 4.0,),
               if(model.discount !=0)
                 Text('${model.oldPrice.round()}',
                   style: TextStyle(
                       color: Colors.grey
                   ),
                 ),
                Spacer(),
                IconButton(
                  onPressed: (){
                   ShopAppcubit.get(context).changeFavState(model.id!);
                  },
                  icon:ShopAppcubit.get(context).favourites![model.id]! ? Icon(Icons.favorite,color: deafultColor,)
                      :Icon(Icons.favorite_border)
                )
              ],
            ),
            ],
          ),
        )

    ],
  ),
);

Widget buildCategoriesItem(DataModel model)=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child: Column(
    children: [
      CircleAvatar(
        radius: 70.0,
        backgroundImage: NetworkImage(model.image),
      ),
      Text(model.name,
        textAlign: TextAlign.center,
      )
    ],
  ),
);







































































