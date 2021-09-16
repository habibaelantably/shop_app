
import 'package:shop_app/Network/local/cacheHelper.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/modules/login/loginScreen.dart';

void logout(context)
{
  cacheHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      NavigateAndKill(context, LoginScreen());
    }
  });
}
void printFullText (String? text)
{
  final pattern=RegExp('.{1,800}'); //800 is the size of each chunk
  pattern.allMatches(text!).forEach((match)=>print(match.group(0)));
}

String token='';