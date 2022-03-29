

class changeFavoritesModel
{
  bool? status;
  String? message;
 // FavoritesData? data;

  changeFavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status=json['status'];
    message=json['message'];
    //data=FavoritesData.fromJson(json['data']);
  }

}
// class FavoritesData
// {
//   int? id;
//
//   FavoritesData.fromJson(Map<String, dynamic>json)
//   {
//     id=json['id'];
//   }
// }