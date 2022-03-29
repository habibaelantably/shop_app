

class HomeModel
{
  bool? status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel
{
  List<BannersModel>banners=[];
  List<ProductsModel>products=[];

  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
   json['banners'].forEach((Element){
     banners.add(BannersModel.fromJson(Element));
   });

    json['products'].forEach((Element)
    {
      products.add(ProductsModel.fromJson(Element));
    });
  }
}

class BannersModel
{
    int? id;
    String? image;
    BannersModel.fromJson(Map<String,dynamic>json)
    {
      id=json['id'];
      image=json['image'];
    }
}

class ProductsModel
{
  int? id;
  dynamic Price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavourites;
  bool? inCart;

  ProductsModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    Price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavourites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}