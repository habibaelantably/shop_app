

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopStates.dart';
import 'package:shop_app/styles/colors.dart';

class SettingsScreen extends StatelessWidget
{
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit,ShopAppStates>(
      listener: (BuildContext context, state)
      {

      },
      builder: (BuildContext context, Object? state)
      {
        var model=ShopAppcubit.get(context).userData;

        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;
        return  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              deafultFormField(
                  controller: nameController,
                  type: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'enter your name';
                    }
                    return null;
                  },
                  prefix: Icons.person,
                  label: 'name'
              ),
              SizedBox(height: 15.0,),
              deafultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'enter your email';
                    }
                    return null;
                  },
                  prefix: Icons.email,
                  label: 'Email Address'
              ),
              SizedBox(height: 15.0,),
              deafultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return '';
                    }
                    return null;
                  },
                  prefix: Icons.phone,
                  label: 'phone'
              ),
              SizedBox(height: 20.0,),

              deafultbutton(
                function: ()
                {
                  logout(context);
                },
                text:'logout',
                background: deafultColor,
              ),
               SizedBox(height: 20.0,),

              deafultbutton(
                function: ()
                {
                  ShopAppcubit.get(context).Update(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text);
                },
                text:'update',
                background: deafultColor,
              ),
            ],
          ),
        );
      },

    );
  }

}