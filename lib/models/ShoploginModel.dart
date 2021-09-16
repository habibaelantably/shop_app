
class ShopLoginModel
{
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJason(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null ? UserData.fromJson(json['data']) : null;
  }

}

class UserData
{
  int? id ;
  String? name;
  String? email;
  String? phone;
  String? Image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    Image=json['Image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];

  }
}