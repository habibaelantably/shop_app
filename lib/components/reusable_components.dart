

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/Network/local/cacheHelper.dart';


Widget deafultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Function? Onsubmite,
  Function ? Onchanged,
  required Function validator,
  String ? label,
  IconData ? prefix,
  bool IsPassword=false ,
  IconData ? suffix,
  Function ? suffixButton,

})=>  TextFormField(
  controller: controller,
  keyboardType: type,
  validator: (String ? value){
    return validator(value);
  },
  obscureText: IsPassword,
  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: (){
        suffixButton!();
      },
      icon: Icon(
          suffix
      ),
    ): null,




  ),
);



Widget deafultbutton({
  double width=double.infinity,
  Color background = Colors.blue,
  bool IsUpperCase=true,
  double radius=0.0,
  required Function function,
  required String text,

})=>Container(
  width: width,
  child: MaterialButton(
    onPressed:(){
      function();
    },
    child: Text(
      IsUpperCase?text.toUpperCase():text,
      style:TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: background,
  ),
);



Widget myDivider() => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(
    height: 1.0,
    color: Colors.grey,
  ),
);

void NavigateTo(context,widget) => Navigator.push(context,
    MaterialPageRoute(
        builder: (context)=> widget
    ));

void NavigateAndKill(context,widget) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(
        builder: (context)=> widget
    ),(Route <dynamic> route){return false;});

void showToast({
  required String text,
  required ToastStates states
})=> Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: setToatColor(states),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color setToatColor(ToastStates states)
{
  Color ?color;

  switch(states)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
    break;
    
    case ToastStates.ERROR:
      color=Colors.red;
    break;
    
    case ToastStates.WARNING:
      color=Colors.yellow;
    break;
  }
  return color;
}

