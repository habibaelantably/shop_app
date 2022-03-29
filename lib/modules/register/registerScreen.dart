
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/cacheHelper.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/layouts/ShopLayout.dart';
import 'package:shop_app/shared/cubit/ShopRegisteCubit.dart';
import 'package:shop_app/shared/cubit/ShopRegisterStates.dart';


class RegisterScreen extends StatelessWidget
{

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();

  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterAppStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar:AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Text(
                        'register now to browse our hot offers ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 40.0,),
                      deafultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (value)
                          {
                            if(value!.isEmpty){
                              return 'please enter your name';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                          label: 'name'
                      ),
                      SizedBox(height: 40.0,),
                      deafultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value!.isEmpty){
                              return 'please enter emailaddress';
                            }
                            return null;
                          },
                          prefix: Icons.email,
                          label: 'Email Address'
                      ),
                      SizedBox(height: 15,),
                      deafultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validator: (value)
                          {
                            if(value!.isEmpty){
                              return 'please enter password';
                            }
                            return null;
                          },
                          IsPassword: ShopRegisterCubit.get(context).isPassword,
                          prefix: Icons.vpn_key,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixButton: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisibilityRegister();
                          },
                          label: 'password'
                      ),
                      SizedBox(height: 15,),

                      deafultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (value)
                          {
                            if(value!.isEmpty){
                              return 'please enter phone number';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                          label: 'phone'
                      ),
                      SizedBox(height: 20.0,),
                      BuildCondition(
                        condition: state is! ShopAppLoadingRegisterstate ,
                        builder: (context)=>deafultbutton(
                            function:()
                            {
                              if(formkey.currentState != null && formkey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,

                                );
                              }
                            },
                            text: 'register'.toUpperCase()
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator()),

                      ),
                    ],
                  ),
                ),
              ),
            ),

          );
        },
        listener: (BuildContext context, Object? state)
        {
          if(state is ShopAppSuccessRegisterState)
          {
            if(state.loginModel.status==true)
            {
              print(state.loginModel.status);
              print(state.loginModel.message);
              //print(state.loginModel.data!.token);
              // showToast(states: ToastStates.SUCCESS,text:state.loginModel.message.toString() );
              cacheHelper.saveData
                (key: 'token',
                  value: state.loginModel.data!.token)
                  .then((value) {
                if(value){

                  token=state.loginModel.data!.token;
                  NavigateAndKill(context, shoplayoutScreen());

              //print(state.loginModel.status);
              //print(state.loginModel.message);
              //print(state.loginModel.data!.token);
              // showToast(states: ToastStates.SUCCESS,text:state.loginModel.message.toString() );
              // cacheHelper.saveData
              //   (key: 'token',
              //     value: state.loginModel.data!.token)
              //     .then((value) {
              //   if(value){
              //     token=state.loginModel.data!.token;
                 print('success register now you can shop');
              //     NavigateAndKill(context, shoplayoutScreen());
                }
              });

            }else
            {
              print(state.loginModel.message);

              showToast(states: ToastStates.ERROR,text:state.loginModel.message.toString() );

            }

          }
        },

      ),
    );
  }

}