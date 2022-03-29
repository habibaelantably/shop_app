
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Network/local/cacheHelper.dart';
import 'package:shop_app/components/constants.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/layouts/ShopLayout.dart';
import 'package:shop_app/modules/register/registerScreen.dart';
import 'package:shop_app/shared/cubit/AppStates.dart';
import 'package:shop_app/shared/cubit/ShopLoginCubit.dart';
import 'package:shop_app/shared/cubit/ShopLoginStates.dart';


class LoginScreen extends StatelessWidget
{

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopAppLoginCubit(),
      child: BlocConsumer<ShopAppLoginCubit,ShopAppLoginStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar:AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Text(
                          'login now to browse our hot offers ',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 40.0,),
                        deafultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value)
                            {
                              if(value!.isEmpty){
                                return 'please enter email address';
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
                            IsPassword: ShopAppLoginCubit.get(context).isPassword,
                            prefix: Icons.vpn_key,
                            suffix: ShopAppLoginCubit.get(context).suffix,
                            suffixButton: ()
                            {
                             ShopAppLoginCubit.get(context).changePasswordVisibility();

                            },
                            label: 'password'
                        ),
                        SizedBox(height: 20.0,),
                        BuildCondition(
                          condition: state is! ShopAppLoginLoadingState,
                          builder: (context)=>deafultbutton(
                              function:()
                              {
                                if(formkey.currentState != null && formkey.currentState!.validate())
                                {
                                  ShopAppLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                              }
                                },
                              text: 'login'.toUpperCase()
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          children: [
                            Text(
                                'Don`t have an account?'
                            ),
                            TextButton(
                                onPressed: ()
                                {
                                  NavigateTo(context, RegisterScreen());
                                },
                                child: Text('Creat an account'))
                          ],
                        )
                      ],

                    ),
                  ),
                ),
              ),
            ),

          );
        },
        listener: (BuildContext context, Object? state)
        {
          if(state is ShopAppLoginSuccessState)
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